#!/bin/bash

BURP_MCP_URL="http://127.0.0.1:9876"
MCP_NAME="burp"

echo "========================================"
echo " Burp Suite + Claude Code MCP Setup"
echo "========================================"
echo

# ======================================
# Check Claude Code
# ======================================

if ! command -v claude > /dev/null 2>&1; then
    echo "[ERROR] Claude Code is not installed."
    echo
    echo "Install Claude Code first:"
    echo "  curl -fsSL https://claude.ai/install.sh | bash"
    echo
    echo "Then run this script again."
    exit 1
fi

echo "[+] Claude Code found:"
claude --version || true
echo

# ======================================
# Check Burp MCP endpoint
# ======================================

echo "[+] Checking Burp MCP server at $BURP_MCP_URL ..."
echo

if curl -fsS --max-time 3 "$BURP_MCP_URL" > /dev/null 2>&1; then
    echo "[+] Burp MCP endpoint is reachable."
else
    echo "[WARNING] Burp MCP endpoint is not reachable at: $BURP_MCP_URL"
    echo
    echo "Make sure:"
    echo "  1. Burp Suite Professional is running"
    echo "  2. The Burp MCP extension is enabled"
    echo "  3. Burp MCP is listening on 127.0.0.1:9876"
    echo
    read -rp "Continue anyway? [y/N]: " answer </dev/tty

    if [[ ! "$answer" =~ ^[Yy]$ ]]; then
        echo
        echo "Setup cancelled."
        exit 1
    fi
fi

echo

# ======================================
# Register Burp MCP in Claude Code
# ======================================

echo "[+] Checking existing Claude MCP configuration..."

if claude mcp get "$MCP_NAME" > /dev/null 2>&1; then
    echo "[+] Existing '$MCP_NAME' MCP entry found — removing old config..."
    claude mcp remove "$MCP_NAME"
fi

echo "[+] Adding Burp MCP server..."

claude mcp add \
    --transport sse \
    "$MCP_NAME" \
    "$BURP_MCP_URL" \
    --scope user

echo

# ======================================
# Done
# ======================================

echo "========================================"
echo " Setup Complete!"
echo "========================================"
echo
echo "[+] Registered MCP servers:"
claude mcp list
echo
echo "Next steps:"
echo "  1. Start Burp Suite Professional"
echo "  2. Enable the Burp MCP extension"
echo "  3. Run:  claude"
echo "  4. Inside Claude Code, run:  /mcp"
echo "  5. Confirm 'burp' shows as connected"
echo
