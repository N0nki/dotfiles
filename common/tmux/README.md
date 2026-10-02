# Coding-agent status in the session chooser

`Ctrl-t → s` opens a session chooser with Claude Code and Codex status.
Sessions with approval requests appear first. The list and preview refresh
every two seconds, preserving the selected session by its ID.
The preview shows every pane, followed by the active pane's terminal content.

| Label                | Meaning                                           |
| -------------------- | ------------------------------------------------- |
| 🟡 Awaiting approval | A tool needs permission                           |
| 🟡 Awaiting input    | Claude is waiting for an MCP elicitation response |
| 🔴 Error             | Claude ended its response with an API error       |
| 🔵 Running           | A prompt is being processed                       |
| 🟢 Turn complete     | The main agent finished responding                |
| ⚪ Idle              | The agent started, or Codex was interrupted       |

## Activation

The usual `~/.tmux.conf`, `~/.claude/settings.json`, and
`~/.codex/config.toml` symlinks must point into this repository.
Reload tmux with `Ctrl-t → r` and start or resume the CLI agents.
In Codex, open `/hooks` and review/trust the new tmux status hooks.
Codex skips untrusted hooks. No extra symlinks or Python packages are needed.

Requires Python 3, tmux with pane user options, and fzf 0.74 or newer
(`every(N)` and `--id-nth` are used for live updates).

## State tracking

`agent-status.py hook claude|codex` receives hook JSON and stores only the
agent name, session/process identity, pending request keys, and state in the
pane's `@coding_agent` option. It does not store prompts or tool arguments.
Hooks return neutral JSON and do not approve, deny, or block anything.
Events with a subagent ID or a different session ID are ignored.
Exited processes and dead panes are excluded from summaries, including
after an abrupt CLI exit. Existing agents without hook records have no label.

Completion means that a response ended; it does not certify task success.
Codex plan questions currently have no dedicated lifecycle hook in this
configuration. They do not appear as input waiting. Remote agents over SSH
do not update local tmux state.
