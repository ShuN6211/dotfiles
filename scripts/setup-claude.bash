#!/usr/bin/env bash
# Register Claude Code MCP servers in the user scope (~/.claude.json).
# MCP servers cannot be defined in settings.json, so they are added here.
# Authorize each server once per machine from `claude` -> /mcp.
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

command -v claude >/dev/null || exit 0

add_http_server() {
    local name="$1" url="$2"
    if claude mcp get "$name" >/dev/null 2>&1; then
        echo "MCP server $name is already registered."
    else
        claude mcp add --scope user --transport http "$name" "$url"
    fi
}

add_http_server docbase-mcp https://mcp.docbase.io/mcp
