#!/usr/bin/env python3
"""Record coding-agent hooks in tmux pane options and render session status."""

import collections
import json
import os
import re
import subprocess
import sys
import time


OPTION = "@coding_agent"
SEPARATOR = "\x1f"
STATES = {
    "approval": ("🟡 Awaiting approval", 33),
    "input": ("🟡 Awaiting input", 33),
    "error": ("🔴 Error", 31),
    "running": ("🔵 Running", 34),
    "complete": ("🟢 Turn complete", 32),
    "idle": ("⚪ Idle", 90),
}
EVENT_STATES = {
    "SessionStart": "idle",
    "UserPromptSubmit": "running",
    "PreToolUse": "running",
    "PostToolUse": "running",
    "PostToolUseFailure": "running",
    "PermissionRequest": "approval",
    "PermissionDenied": "running",
    "Elicitation": "input",
    "ElicitationResult": "running",
    "Stop": "complete",
    "StopFailure": "error",
    "Interrupt": "idle",
}


def command(*args):
    """Use argv, never a shell, for session names and hook input."""
    return subprocess.run(
        args, check=True, capture_output=True, text=True, timeout=2,
        env={**os.environ, "LC_ALL": "C"},
    ).stdout.rstrip("\n")


def processes():
    result = {}
    for line in command("ps", "-axo", "pid=,ppid=,lstart=,comm=").splitlines():
        fields = line.split(None, 7)
        if len(fields) == 8:
            result[int(fields[0])] = {
                "parent": int(fields[1]),
                "started": " ".join(fields[2:7]),
                "command": fields[7],
            }
    return result


def read_record(value):
    try:
        record = json.loads(value)
        return record if isinstance(record, dict) else {}
    except (ValueError, TypeError):
        return {}


def alive(record, table):
    process = table.get(record.get("pid"))
    return bool(process and process["started"] == record.get("started"))


def agent_owner(agent, pane_pid, table):
    """Find the CLI ancestor, including version-named Claude executables."""
    pid = os.getppid()
    owner = None
    visited = set()
    while pid in table and pid not in visited:
        visited.add(pid)
        executable = table[pid]["command"]
        if owner is None and (re.fullmatch(agent + r"(?:[-.].*)?", os.path.basename(executable))
                              or f"/{agent}/" in executable):
            owner = pid
        if pid == pane_pid:
            return owner
        pid = table[pid]["parent"]
    # A hook without an ancestor in this pane must not update its state.
    return None


def record_hook(agent, payload):
    if not isinstance(payload, dict):
        return
    pane = os.environ.get("TMUX_PANE", "")
    if not os.environ.get("TMUX") or not re.fullmatch(r"%\d+", pane):
        return
    if payload.get("agent_id"):
        return
    event = payload.get("hook_event_name")
    state = EVENT_STATES.get(event)
    if event == "Notification":
        state = {
            "permission_prompt": "approval",
            "elicitation_dialog": "input",
            "elicitation_url_dialog": "input",
        }.get(payload.get("notification_type"))
    if state is None and event != "SessionEnd":
        return

    info = command("tmux", "display-message", "-p", "-t", pane,
                   "#{pane_pid}" + SEPARATOR + "#{" + OPTION + "}")
    pane_pid, value = info.split(SEPARATOR, 1)
    table = processes()
    owner = agent_owner(agent, int(pane_pid), table)
    if owner is None:
        return
    previous = read_record(value)
    session = payload.get("session_id")
    if not isinstance(session, str) or not session:
        return
    if alive(previous, table):
        if previous.get("pid") != owner:
            return
        if event != "SessionStart" and previous.get("session_id") != session:
            return
        if event == "SessionStart" and payload.get("source") == "compact":
            return
    if event == "SessionEnd":
        command("tmux", "set-option", "-p", "-u", "-t", pane, OPTION)
        return

    same_session = (alive(previous, table)
                    and previous.get("session_id") == session)
    pending = dict(previous.get("pending", {})) if same_session else {}
    tool_key = str(payload.get("tool_use_id") or payload.get("tool_name") or "tool")
    if event in ("PermissionRequest", "Elicitation"):
        pending[tool_key] = state
    elif event == "Notification":
        # A delayed notification repeats the original permission/input event.
        if state not in pending.values():
            pending["notification"] = state
    elif event in ("PostToolUse", "PostToolUseFailure", "PermissionDenied", "ElicitationResult"):
        pending.pop(tool_key, None)
        pending.pop("notification", None)
    elif event in ("UserPromptSubmit", "Stop", "StopFailure", "Interrupt", "SessionStart"):
        pending.clear()
    if pending:
        state = "approval" if "approval" in pending.values() else "input"
    elif (same_session and event in ("PreToolUse", "PostToolUse", "PostToolUseFailure")
          and previous.get("state") in ("idle", "complete", "error")):
        # Background tool completions must not restart a finished main turn.
        return

    record = {
        "agent": agent,
        "session_id": session,
        "pid": owner,
        "started": table[owner]["started"],
        "state": state,
        "pending": pending,
        "updated": int(time.time()),
    }
    command("tmux", "set-option", "-p", "-t", pane, OPTION,
            json.dumps(record, separators=(",", ":")))


def clean(value):
    """Keep terminal controls, tabs, and newlines out of list labels."""
    return "".join(char if char.isprintable() else " " for char in value)


def color(state, suffix=""):
    label, code = STATES[state]
    return f"\033[{code}m{label}{suffix}\033[0m"


def panes(session=None):
    fields = (
        "session_id", "window_index", "window_name", "pane_index", "pane_id",
        "pane_current_command", "pane_current_path", "pane_dead", OPTION,
    )
    args = ["tmux", "list-panes"]
    args.extend(["-s", "-t", session] if session else ["-a"])
    args.extend(["-F", SEPARATOR.join("#{" + field + "}" for field in fields)])
    table = processes()
    result = []
    for line in command(*args).splitlines():
        values = line.split(SEPARATOR, len(fields) - 1)
        if len(values) != len(fields):
            continue
        pane = dict(zip(fields, values))
        record = read_record(pane[OPTION])
        if (pane["pane_dead"] != "1" and alive(record, table)
                and record.get("state") in STATES):
            pane["record"] = record
        else:
            pane["record"] = {}
        result.append(pane)
    return result


def list_sessions():
    counts = collections.defaultdict(collections.Counter)
    for pane in panes():
        record = pane["record"]
        if record:
            counts[pane["session_id"]][record["state"]] += 1
    sessions = []
    output = command("tmux", "list-sessions", "-F",
                     "#{session_id}" + SEPARATOR + "#{session_name}")
    for line in output.splitlines():
        session, name = line.split(SEPARATOR, 1)
        count = counts[session]
        summary = " ".join(color(state, f" ×{count[state]}")
                           for state in STATES if count[state])
        priority = next((index for index, state in enumerate(STATES)
                         if count[state]), len(STATES))
        sessions.append((priority, name, session, summary))
    for _, name, session, summary in sorted(sessions):
        print(f"{session}\t{clean(name)}  {summary}".rstrip())


def preview(session):
    print("── Pane status ──")
    for pane in sorted(panes(session),
                       key=lambda item: (int(item["window_index"]),
                                         int(item["pane_index"]))):
        record = pane["record"]
        name = record.get("agent", pane["pane_current_command"])
        state = color(record["state"]) if record else ""
        print(f"{pane['window_index']}.{pane['pane_index']} "
              f"{clean(pane['window_name'])} / {clean(name)} {state}")
        print(f"    {clean(pane['pane_current_path'])}")


def main():
    mode = sys.argv[1]
    if mode == "hook":
        # Always return neutral JSON, including outside tmux and on failure.
        # Notification hooks must never change permission/Stop decisions.
        try:
            record_hook(sys.argv[2], json.load(sys.stdin))
        except (OSError, ValueError, TypeError, subprocess.SubprocessError):
            pass
        print("{}")
    elif mode == "list":
        list_sessions()
    elif mode == "preview":
        preview(sys.argv[2])


if __name__ == "__main__":
    try:
        main()
    except (OSError, ValueError, subprocess.SubprocessError) as error:
        print(f"tmux agent status: {error}", file=sys.stderr)
        sys.exit(1)
