# AI Coding Templates

Unified configuration templates for **Claude Code**, **Cursor**, and **Antigravity**.

## Quick Start

```bash
# Clone and customize
git clone https://github.com/jeremyspofford/ai-coding-templates.git my-project
cd my-project && rm -rf .git && git init

# Or use the setup script
./scripts/setup-project.sh --name my-project --tools all
```

## What's Included

| Tool | Config Dir | Features |
| ---- | ---------- | -------- |
| Claude Code | `.claude/` | Plugins, rules, skills |
| Cursor | `.cursor/` | Rules (`.mdc`), commands |
| Antigravity | `.agent/` | Rules, workflows |

## Documentation

- **[docs/OVERVIEW.md](docs/OVERVIEW.md)** - Full project description
- **[docs/QUICK_START.md](docs/QUICK_START.md)** - 5-minute setup guide
- **[docs/SETUP_GUIDE.md](docs/SETUP_GUIDE.md)** - Tool-specific configuration
- **[docs/TOOL_REFERENCE.md](docs/TOOL_REFERENCE.md)** - Tool comparison
- **[docs/WORKFLOWS.md](docs/WORKFLOWS.md)** - Development workflows
- **[docs/FAQ.md](docs/FAQ.md)** - Common questions

## Customization

After setup, edit per project:

- `.claude/CLAUDE.md` - Project guidelines
- `.claude/config.json` - Plugins
- `.cursor/rules/` - Cursor rules
- `.agent/workflows/` - Antigravity workflows

## License

[Add your license]

---

**For:** Claude Code, Cursor, Antigravity
