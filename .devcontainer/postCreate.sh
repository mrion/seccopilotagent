#!/usr/bin/env bash
# .devcontainer/postCreate.sh
# Runs once inside the container after creation (as the sec-copilot user).

set -euo pipefail

echo "=== Security Copilot Agent Dev Container – post-create setup ==="

# ── npm: install MCP package locally if not already present ──────────────────
if ! command -v azure-mcp &>/dev/null && [ -f package.json ]; then
    echo "-> Installing npm dependencies..."
    npm install
fi

# ── Configure git defaults (non-fatal if already set) ────────────────────────
git config --global core.autocrlf input    2>/dev/null || true
git config --global pull.rebase false      2>/dev/null || true

# ── Azure CLI – prompt user to log in on first use ───────────────────────────
echo ""
echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║  Run  'az login'  or  'az login --use-device-code'              ║"
echo "║  to authenticate with Azure before using Sentinel / MCP tools.  ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo ""

echo "=== Post-create setup complete ==="
