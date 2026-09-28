#!/bin/bash

set -e

BURP_MCP_URL="http://127.0.0.1:9876"
MCP_NAME="burp"

echo "======================================"
echo " Burp Suite + Claude Code MCP Setup"
echo "======================================"
echo

# Check Claude Code
if ! command -v claude >/dev/null 2>&1; then
    echo "[ERROR] Claude Code was not found."
    echo
    echo "Install Claude Code first, then run this script again."
    exit 1
fi

echo "[+] Claude Code found:"
claude --version || true
echo

# Check Burp MCP endpoint
echo "[+] Checking Burp MCP server..."

if curl -fsS --max-time 3 "$BURP_MCP_URL" >/dev/null 2>&1; then
    echo "[+] Burp MCP endpoint is reachable."
else
    echo "[WARNING] Burp MCP endpoint is not reachable at:"
    echo "         $BURP_MCP_URL"
    echo
    echo "Make sure:"
    echo "  1. Burp Suite Professional is running"
    echo "  2. Burp MCP server is enabled"
    echo "  3. Burp MCP is listening on 127.0.0.1:9876"
    echo
    read -rp "Continue anyway? [y/N]: " answer

    if [[ ! "$answer" =~ ^[Yy]$ ]]; then
        echo "Setup cancelled."
        exit 1
    fi
fi

echo
echo "[+] Checking existing Claude MCP configuration..."

# Remove existing Burp MCP configuration if present
if claude mcp get "$MCP_NAME" >/dev/null 2>&1; then
    echo "[+] Existing '$MCP_NAME' MCP server found."
    echo "[+] Removing old configuration..."
    claude mcp remove "$MCP_NAME"
fi

echo
echo "[+] Adding Burp MCP server..."

claude mcp add     --transport sse     "$MCP_NAME"     "$BURP_MCP_URL"     --scope user

echo
echo "======================================"
echo " Burp MCP Setup Complete"
echo "======================================"
echo

echo "[+] Current MCP servers:"
claude mcp list

echo
echo "Next:"
echo "  1. Start Burp Suite Professional"
echo "  2. Make sure the Burp MCP server is enabled"
echo "  3. Run:"
echo
echo "     claude"
echo
echo "  4. Inside Claude Code run:"
echo
echo "     /mcp"
echo
echo "  5. Confirm that 'burp' is connected."
echo
