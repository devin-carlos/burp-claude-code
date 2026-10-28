# Burp Suite + Claude Code MCP Setup

> One-line installer that connects **Claude Code** to **Burp Suite Professional** via the Burp MCP server — on any Linux system.

![Shell](https://img.shields.io/badge/shell-bash%20%7C%20zsh-blue)
![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Kali-lightgrey)
![License](https://img.shields.io/badge/license-MIT-green)

---

## Table of Contents

- [Quick Start](#quick-start)
- [Requirements](#requirements)
- [How It Works](#how-it-works)
- [Manual Setup](#manual-setup)
- [Verify](#verify)
- [Troubleshooting](#troubleshooting)
- [Security](#security)

---

## Quick Start

Start Burp Suite Professional and enable its MCP server, then run:

```bash
curl -fsSL https://raw.githubusercontent.com/devin-carlos/burp-claude-code/main/setup-burp-claude.sh | bash
```

The script checks for Claude Code, pings the Burp MCP endpoint, then registers `burp` as a user-scoped MCP server in Claude Code.

---

## Requirements

| Requirement | Notes |
|-------------|-------|
| Linux (any distro) | Kali, Ubuntu, Debian, Arch, etc. |
| Claude Code | Installed and on `$PATH` |
| Burp Suite Professional | With MCP extension enabled |
| Burp MCP endpoint | Listening on `http://127.0.0.1:9876` |

> Don't have Claude Code? Install it first:
> ```bash
> curl -fsSL https://claude.ai/install.sh | bash
> ```

---

## How It Works

```
┌──────────────────────────────────────────────┐
│   curl ... | bash                            │
│                                              │
│  1. Check Claude Code is installed           │
│  2. Ping Burp MCP endpoint (127.0.0.1:9876) │
│  3. Remove any old 'burp' MCP entry          │
│  4. Register Burp as user-scoped MCP server  │
│  5. Print confirmation + next steps          │
└──────────────────────────────────────────────┘
```

---

## Manual Setup

```bash
git clone https://github.com/devin-carlos/burp-claude-code.git
cd burp-claude-code
chmod +x setup-burp-claude.sh
./setup-burp-claude.sh
```

---

## Verify

After setup, confirm the MCP server is registered:

```bash
claude mcp list
```

Then launch Claude Code:

```bash
claude
```

Inside Claude Code, run:

```
/mcp
```

Confirm that `burp` shows as **connected**.

---

## Troubleshooting

### Burp MCP endpoint unreachable

Check manually:

```bash
curl -v http://127.0.0.1:9876
```

If it fails:

1. Open Burp Suite Professional
2. Go to **Extensions → Installed** and confirm the MCP extension is active
3. Verify it is set to listen on `127.0.0.1:9876`

### Claude Code not found

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Then re-run `setup-burp-claude.sh`.

### MCP server not showing in `/mcp`

Re-run the script — it removes and re-adds the entry cleanly:

```bash
bash setup-burp-claude.sh
```

---

## Security

- Only connect Claude Code to Burp instances and targets **you are authorized to test**.
- Keep Burp MCP bound to `localhost` (`127.0.0.1`) unless you have a specific, secured reason to expose it remotely.
- Do not expose port `9876` through firewalls or tunnels without proper authentication.

---

## Disclaimer

This project is an independent setup utility and is not affiliated with or endorsed by PortSwigger, Anthropic, or Claude.
