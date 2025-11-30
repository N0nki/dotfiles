#!/bin/bash
#
# format_lua.sh
# Claude Code hook script to automatically format Lua files with stylua
#
# This script is triggered by Claude Code's ToolResult hook when
# Edit or Write tools are used on .lua files.
#

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if stylua is installed
if ! command -v stylua &> /dev/null; then
    echo -e "${YELLOW}[stylua] stylua is not installed. Skipping Lua formatting.${NC}" >&2
    echo -e "${YELLOW}[stylua] Install with: cargo install stylua${NC}" >&2
    exit 0
fi

# Function to format a single Lua file
format_lua_file() {
    local file="$1"

    if [ ! -f "$file" ]; then
        return 0
    fi

    # Check if file has .lua extension
    if [[ "$file" != *.lua ]]; then
        return 0
    fi

    echo -e "${BLUE}[stylua] Formatting: $file${NC}" >&2

    # Run stylua
    if stylua "$file"; then
        echo -e "${GREEN}[stylua] ✓ Formatted: $file${NC}" >&2
    else
        echo -e "${RED}[stylua] ✗ Failed to format: $file${NC}" >&2
        return 1
    fi
}

# Main logic
main() {
    # Method 1: Read file path from stdin (if provided by hook)
    if [ -p /dev/stdin ]; then
        while IFS= read -r line; do
            # Try to extract file paths from the input
            # Look for patterns like "file_path": "..." in JSON
            if echo "$line" | grep -q '"file_path"'; then
                file_path=$(echo "$line" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
                if [ -n "$file_path" ]; then
                    format_lua_file "$file_path"
                fi
            fi
        done
    fi

    # Method 2: Check git working directory for modified .lua files
    # This catches files that were just edited
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # Get list of modified .lua files (both staged and unstaged)
        modified_lua_files=$(git diff --name-only HEAD 2>/dev/null | grep '\.lua$' || true)

        if [ -n "$modified_lua_files" ]; then
            echo -e "${BLUE}[stylua] Found modified Lua files in git working directory${NC}" >&2
            while IFS= read -r file; do
                format_lua_file "$file"
            done <<< "$modified_lua_files"
        fi

        # Also check unstaged changes
        unstaged_lua_files=$(git diff --name-only 2>/dev/null | grep '\.lua$' || true)

        if [ -n "$unstaged_lua_files" ]; then
            while IFS= read -r file; do
                # Only format if not already formatted above
                if ! echo "$modified_lua_files" | grep -q "^$file$"; then
                    format_lua_file "$file"
                fi
            done <<< "$unstaged_lua_files"
        fi
    fi

    # Method 3: If specific file is passed as argument
    if [ $# -gt 0 ]; then
        for file in "$@"; do
            format_lua_file "$file"
        done
    fi
}

# Run main function
main "$@"

exit 0
