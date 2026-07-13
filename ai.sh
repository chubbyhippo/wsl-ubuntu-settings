#!/usr/bin/env sh

# AI coding CLIs — Claude Code, OpenAI Codex, Google Gemini — installed
# globally with npm (node comes from mise; rerun any time to update).

# mise + local bin on PATH, so npm resolves when piped into sh
export PATH="$HOME/.local/bin:$HOME/.local/share/mise/shims:$PATH"

npm install -g \
    @anthropic-ai/claude-code \
    @openai/codex \
    @google/gemini-cli
