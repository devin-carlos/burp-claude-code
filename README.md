# Burp Suite + Claude Code MCP Setup

A simple installer for connecting Claude Code to Burp Suite Professional through the Burp MCP server.

## Requirements

- Kali Linux / Linux
- Claude Code installed
- Burp Suite Professional installed
- Burp MCP server enabled
- Burp MCP endpoint available at `http://127.0.0.1:9876`

## Quick Setup

Start Burp Suite Professional and enable its MCP server.

Then run:

```bash
curl -fsSL https://raw.githubusercontent.com/devin-carlos/burp-claude-code/main/setup-burp-claude.sh | bash
```

The installer checks for Claude Code and the Burp MCP endpoint, then registers `burp` as a user-scoped MCP server in Claude Code.

## Manual Setup

Clone the repository:

```bash
git clone https://github.com/devin-carlos/burp-claude-code.git
cd burp-claude-code
chmod +x setup-burp-claude.sh
./setup-burp-claude.sh
```

## Verify

After setup:

```bash
claude mcp list
```

Then start Claude Code:

```bash
claude
```

Inside Claude Code:

```text
/mcp
```

Confirm that the `burp` MCP server is connected.

## Troubleshooting

If the script reports that the Burp MCP endpoint is unreachable, check:

1. Burp Suite Professional is running.
2. Burp MCP is enabled.
3. The MCP server is listening on `127.0.0.1:9876`.

Check the endpoint manually:

```bash
curl -v http://127.0.0.1:9876
```

## Security

Only connect Claude Code to Burp instances and targets you are authorized to test.

Keep Burp MCP bound to localhost unless you have a specific, secured reason to expose it remotely.

## Repository

https://github.com/devin-carlos/burp-claude-code

## Disclaimer

This project is an independent setup utility and is not affiliated with or endorsed by PortSwigger, Anthropic, or Claude.
