# AI Coding Templates - Overview

## Purpose

This repository solves a common problem: **How do I set up consistent configurations across multiple AI coding tools and projects?**

Instead of manually configuring each tool for each project, developers can:

1. Clone this template and customize for their project
2. Copy tool-specific configs into existing projects
3. Use the setup script for automated project bootstrap

## What's Included

### Templates for Three AI Tools

| Tool | Configuration | Use Case |
| ---- | ------------- | -------- |
| **Claude Code** | `.claude/` with plugins, rules, skills | Flexible plugin ecosystem, custom tools |
| **Cursor** | `.cursor/` with rules and commands | Fast editing, built-in AI integration |
| **Antigravity** | `.agent/` with rules and workflows | Automation, CI/CD-like pipelines |

### Shared Resources

- **Rules** - Language-agnostic coding standards (both `.md` and `.mdc` formats)
- **Workflows** - Common development patterns
- **Commands** - Useful shortcuts and automations
- **.gitignore** - Common project defaults

## Directory Structure

```text
ai-coding-templates/
├── .claude/              Claude Code configuration
│   ├── config.json       Plugin configuration
│   ├── CLAUDE.md         Project guidelines
│   ├── rules/            Coding standards
│   └── skills/           Custom skills
├── .cursor/              Cursor configuration
│   ├── settings.json     MCP configuration
│   ├── rules/            Rules (.mdc format)
│   └── commands/         Custom commands
├── .agent/               Antigravity configuration
│   ├── AGENT.md          Project guidelines
│   ├── .mcp.json         MCP configuration
│   ├── rules/            Coding standards
│   └── workflows/        Automation workflows
├── docs/                 Documentation
├── scripts/              Automation scripts
└── README.md             Quick start guide
```

## Workflow Configuration

### Claude Code

- **Plugins** - Enable/disable per project in `config.json`
- **Rules** - Markdown files defining coding standards
- **Instructions** - Project-specific guidelines in `CLAUDE.md`
- **Skills** - Domain-specific tools (code-analyzer, markdown-linter, feature-flag)

### Cursor

- **Rules** - `.mdc` format with YAML frontmatter
- **Commands** - Markdown files defining custom commands
- **Configuration** - MCP servers in `settings.json`

### Antigravity

- **Rules** - Standard markdown rules (always-on)
- **Workflows** - Automation steps with triggers
- **Project Instructions** - Guidelines in `AGENT.md`

## Coding Standards Included

All templates include consistent standards:

### 1. Markdown Linting (MD040, MD060)

- All code blocks must have language tags
- Table formatting with proper spacing

### 2. Coding Practices

- TypeScript: No `any` type (use `unknown` instead)
- Prefer `interface` over `type`
- Type safety throughout

### 3. TDD Workflow (Ralph Loop)

- Red (failing test)
- Green (minimal code to pass)
- Refactor (simplify)
- Verify (browser/execution)

### 4. Feature Flag Scaffold

- Infrastructure-first approach
- CDK feature flags
- Safety-first deployment

### 5. Code Analysis

- Correctness, security, performance
- Maintainability, testability, architecture
- Severity-based issue reporting

## Use Cases

### Solo Developer

- Fast project setup
- Consistent configurations across personal projects
- Easy switching between tools

### Small Team

- Shared coding standards
- Consistent automation
- Reduced setup time for new developers

### Large Organization

- Standardized developer experience
- Enforced coding practices
- Central repository for standards
- Easy onboarding

### Open Source Project

- Clear contribution guidelines
- Standardized CI/CD
- Community best practices

## Technical Details

### Language Support

- **Primary:** TypeScript / JavaScript
- **Secondary:** Python, Go, Rust
- **Build:** npm, pip, cargo, etc.

### File Formats

| Tool | Config | Rules | Workflows/Commands |
| ---- | ------ | ----- | ------------------ |
| Claude | `.json` | `.md` | Skills (`.md`) |
| Cursor | `.json` | `.mdc` | Commands (`.md`) |
| Antigravity | `.json` | `.md` | Workflows (`.md`) |

## Integration & Extensibility

### Adding New Tools

To add support for additional tools (e.g., Windsurf, Zed):

1. Create tool-specific directory (e.g., `.windsurf/`)
2. Add configuration files following tool's conventions
3. Create rules in appropriate format
4. Update setup script to include new tool
5. Document in guides

### Customizing Rules

Edit or extend rules for specific projects:

- Keep shared rules in each tool's `rules/` directory
- Add project-specific overrides as needed
- Maintain format consistency (`.md` vs `.mdc`)

## Benefits

### For Developers

- Faster project setup
- Consistent coding standards
- Reduced configuration errors
- Clear best practices

### For Teams

- Unified developer experience
- Easier onboarding
- Consistent code quality
- Reduced configuration drift

### For Organizations

- Enforced standards
- Scalable configuration
- Improved productivity
- Better code consistency

## Limitations

- Requires customization per project
- Some tools may need additional setup
- Not a replacement for IDE configuration

## Future Roadmap

### Planned Enhancements

- Additional tool support (Windsurf, Zed, etc.)
- Automated migration utilities
- Template validation
- Plugin recommendations engine

### Community Contributions

- Additional templates welcome
- Tool-specific enhancements
- Documentation improvements
- Bug reports and fixes

## Related Documentation

- **[QUICK_START.md](QUICK_START.md)** - 5-minute setup
- **[SETUP_GUIDE.md](SETUP_GUIDE.md)** - Tool-specific configuration
- **[TOOL_REFERENCE.md](TOOL_REFERENCE.md)** - Tool comparison
- **[WORKFLOWS.md](WORKFLOWS.md)** - Development workflows
- **[FAQ.md](FAQ.md)** - Common questions

---

**Version:** 1.0
**Updated:** 2026-01-15
