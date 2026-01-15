# Git Hooks with Lefthook

Enforce project standards automatically using Lefthook for git hook management.

---

## Overview

This template uses **Lefthook** - a fast, cross-platform git hook manager
for better git hook management.

**Why Lefthook?**

- ⚡ Fast execution (compiled, not bash)
- 🔄 Cross-platform (Windows, macOS, Linux)
- 📦 Simple YAML configuration
- 🎯 Parallel hook execution
- 🔧 Easy to extend and customize

Automatically enforces:

- **Markdown Linting** (MD040, MD060) - Language tags, table formatting
- **Code Linting** - TypeScript/JavaScript standards (if configured)
- **Commit Message Standards** - (optional, extensible)

---

## Quick Start

### 1. Install Lefthook

Choose one installation method:

```bash
# Option 1: npm (global)
npm install -g @evilmartians/lefthook

# Option 2: Homebrew (macOS)
brew install lefthook

# Option 3: Download binary from GitHub
# https://github.com/evilmartians/lefthook/releases
```

### 2. Create a New Project

```bash
./scripts/setup-project.sh --name my-project --tools claude --git
cd my-project
```

### 3. Install Hooks

```bash
# Initialize lefthook for the project
lefthook install
```

This creates:

- `.git/hooks/pre-commit` - Runs markdown and code linting
- `.git/hooks/commit-msg` - (Optional) Message validation
- `.lefthook.yml` - Hook configuration
- `.lefthookrc.json` - Hook settings

### 4. Test the Hooks

Create or modify a markdown file:

```bash
# Create bad markdown (missing language tag)
cat > test.md << 'EOF'
# Test

\`\`\`
code without language
\`\`\`
EOF

git add test.md
git commit -m "test"
```

**Result**: Commit blocked with linting error (if markdownlint installed)

Fix and retry:

```bash
cat > test.md << 'EOF'
# Test

\`\`\`javascript
const x = 1;
\`\`\`
EOF

git add test.md
git commit -m "test"
```

**Result**: Commit succeeds ✅

---

## Configuration

### `lefthook.yml` - Hook Commands

The main configuration file that defines which hooks run and what they do:

```yaml
pre-commit:
  commands:
    markdown-lint:
      glob: "*.md"
      run: markdownlint -c .markdownlint.json {staged_files}

    code-lint:
      glob: "*.{js,ts,jsx,tsx}"
      run: npm run lint -- {staged_files}
```

**Key concepts:**

- `glob` - Which files to check
- `run` - Command to execute
- `{staged_files}` - Placeholder for changed files
- `skip_output` - Hide output (use `summary` or `meta`)
- `stage_fixed` - Auto-stage fixes

### `.lefthookrc.json` - Global Settings

```json
{
  "skip_output": ["meta"],
  "auto_install": true,
  "source_dir": "."
}
```

**Settings:**

- `skip_output` - Types of output to hide
- `auto_install` - Auto-install on `git clone`
- `source_dir` - Where hooks are defined

### `.markdownlint.json` - Markdown Rules

Generated automatically, configures markdown linting:

```json
{
  "extends": "markdownlint/style/prettier",
  "MD040": {
    "allowed_languages": [
      "bash", "javascript", "typescript", "python",
      "json", "yaml", "sql", "html", "css",
      "dockerfile", "diff", "markdown"
    ]
  },
  "MD013": false,
  "MD033": false
}
```

**Key rules:**

- `MD040` - Fenced code block language tags
- `MD060` - Table column spacing
- `MD013` - Line length (disabled)
- `MD033` - Inline HTML (disabled)

---

## Common Tasks

### Skip Hooks (Emergency Only)

```bash
# Bypass all hooks
git commit --no-verify

# Or with environment variable
SKIP_LEFTHOOK=1 git commit -m "Emergency fix"
```

### Run Hooks Manually

```bash
# Run all hooks
lefthook run pre-commit

# Run specific hook
lefthook run markdown-lint
```

### Uninstall Hooks

```bash
lefthook uninstall
```

### Check Hook Status

```bash
# Show installed hooks
lefthook dump

# Show configuration
lefthook dump --config
```

### Fix Markdown Automatically

```bash
# Fix all markdown files
markdownlint --fix *.md
markdownlint --fix **/*.md

# Fix specific file
markdownlint --fix docs/README.md
```

**What gets fixed:**

- Missing language tags → adds `markdown` default
- Table spacing → normalizes format
- Line endings → standardizes
- List indentation → fixes

### Disable Specific Rule

In markdown file:

```markdown
<!-- markdownlint-disable MD040 -->
```

code without language

```
<!-- markdownlint-enable MD040 -->
```

### Add Custom Hooks

Edit `lefthook.yml`:

```yaml
pre-commit:
  commands:
    custom-check:
      run: ./scripts/custom-validation.sh
      stage_fixed: true
```

---

## Installation & Requirements

### Requirements

- **Lefthook** - The hook manager (install via npm/brew)
- **markdownlint-cli** - For markdown linting (optional but recommended)
- **npm lint script** - For TypeScript/JavaScript (if you have package.json)

### Installation Steps

```bash
# 1. Install lefthook globally
npm install -g @evilmartians/lefthook

# 2. Create project
./scripts/setup-project.sh --name my-project --tools claude --git
cd my-project

# 3. Install hooks
lefthook install

# 4. (Recommended) Install markdownlint for detailed checking
npm install -g markdownlint-cli

# 5. Verify setup
lefthook dump
```

### Without markdownlint

The hooks still work without markdownlint, but will skip markdown linting:

```bash
lefthook install
# Hooks installed but markdown linting unavailable
# Run: npm install -g markdownlint-cli (to enable)
```

### CI/CD Integration

Disable lefthook in CI to speed up builds:

```bash
# GitHub Actions
- name: Run tests
  env:
    SKIP_LEFTHOOK: 1
  run: npm test

# GitLab CI
test:
  script:
    - SKIP_LEFTHOOK=1 npm test

# Jenkins
environment {
  SKIP_LEFTHOOK = '1'
}
```

---

## Troubleshooting

### Hooks Not Running

**Check if lefthook is installed:**

```bash
lefthook --version
```

**Check if hooks are installed:**

```bash
lefthook dump
# Should show: pre-commit, commit-msg, etc.
```

**Reinstall hooks:**

```bash
lefthook install
```

### "Command not found: markdownlint"

Install markdownlint:

```bash
npm install -g markdownlint-cli
```

Or disable markdown linting in `lefthook.yml`:

```yaml
markdown-lint:
  skip: true
```

### "Pre-commit hook failed"

Check the error message - it tells you what's wrong:

```bash
# Example: Fix markdown issues
markdownlint --fix *.md

# Example: Fix code issues
npm run lint -- --fix

# Retry commit
git add .
git commit -m "Fix linting issues"
```

### Hooks Run Too Slowly

Optimize in `lefthook.yml`:

```yaml
pre-commit:
  parallel: true  # Run commands in parallel
  commands:
    # ... commands ...
```

### Lefthook Not Found After Install

On macOS, verify installation:

```bash
which lefthook
# Should show: /usr/local/bin/lefthook

# If not found, reinstall
brew install lefthook
```

---

## Secrets Scanning with git-secrets

The repository automatically scans commits for secrets using [git-secrets](https://github.com/awslabs/git-secrets).

### What Gets Scanned

git-secrets detects:

- **AWS credentials**: Access keys (AKIA...), secret keys, account IDs
- **Private keys**: RSA, DSA, EC, OpenSSH, PGP private keys
- **API keys**: Patterns like `api_key`, `api-key`, `apiKey` with values
- **Tokens**: Access tokens, auth tokens
- **Passwords**: Password assignments in code (`password = "..."`)
- **Connection strings**: Database URLs with embedded credentials

### Installation

**Required**: git-secrets must be installed separately (not an npm package).

```bash
# macOS
brew install git-secrets

# Linux (Ubuntu/Debian)
sudo apt-get install git-secrets

# Linux (manual build)
git clone https://github.com/awslabs/git-secrets.git
cd git-secrets
sudo make install

# Windows
# Download from: https://github.com/awslabs/git-secrets/releases
```

**Auto-initialization**: When you make your first commit, Lefthook will automatically:

1. Detect git-secrets installation
2. Run `git secrets --install` to set up hooks
3. Run `git secrets --register-aws` to add AWS patterns
4. Add custom patterns for API keys, passwords, tokens

### How It Works

```bash
# When you commit, git-secrets scans staged files
git add config.js
git commit -m "Add config"

# If secrets detected:
[ERROR] Matched one or more prohibited patterns
Possible mitigations:
- Mark false positives as allowed
- Fix the secrets
```

**Performance**: Adds ~50-200ms to commit time (negligible).

### Example: Blocked Commit

```bash
$ echo 'AKIAIOSFODNN7EXAMPLE' > test.txt
$ git add test.txt
$ git commit -m "Test"

🔍 Scanning commit for secrets...
test.txt:1:AKIAIOSFODNN7EXAMPLE

[ERROR] Matched one or more prohibited patterns

Possible mitigations:
- Mark false positives as allowed using: git config --add secrets.allowed ...
- Mark false positives as allowed by adding regular expressions to .gitallowed at repository's root directory
- Fix the secrets
```

### Handling False Positives

If git-secrets blocks a legitimate commit:

```bash
# Option 1: Allow specific string for this repository
git secrets --add --allowed 'safe-example-string'

# Option 2: Add to .gitallowed file
echo 'safe-pattern-regex' >> .gitallowed

# Option 3: Skip hook for emergency (USE RARELY)
SKIP=secrets-scan git commit -m "Emergency fix"
```

### What if git-secrets is Not Installed?

Lefthook will show a warning but allow the commit:

```text
⚠️  git-secrets not installed. Secrets scanning disabled.
   Install: brew install git-secrets (macOS)
   See: https://github.com/awslabs/git-secrets

   ⚠️  WARNING: Proceeding without secrets scanning!
```

**Note**: `.gitignore` still prevents most secret files (`.env`, credentials, etc.) from being staged.

### Adding Custom Patterns

```bash
# Add project-specific secret patterns
git secrets --add 'myapp[_-]?secret'
git secrets --add 'internal[_-]?token'

# View all registered patterns
git config --local --get-all secrets.patterns
```

### Testing Secret Protection

```bash
# Test 1: .gitignore blocks .env files
echo "API_KEY=secret" > .env
git add .env
# Expected: "The following paths are ignored..."

# Test 2: git-secrets blocks AWS keys
echo "AKIAIOSFODNN7EXAMPLE" > test.txt
git add test.txt
git commit -m "Test"
# Expected: "[ERROR] Matched one or more prohibited patterns"
```

### Troubleshooting git-secrets

**Problem**: "git-secrets: command not found"

```bash
# Reinstall git-secrets
brew reinstall git-secrets  # macOS
```

**Problem**: git-secrets not running on commits

```bash
# Reinstall Lefthook hooks
lefthook install

# Verify hook exists
cat .git/hooks/pre-commit
```

**Problem**: Too many false positives

```bash
# Review patterns
git config --local --get-all secrets.patterns

# Remove problematic pattern (if needed)
git config --local --unset-all secrets.patterns 'problematic-pattern'
```

### Resources

- [git-secrets GitHub Repository](https://github.com/awslabs/git-secrets)
- [Secrets Management Guide](./../.claude/rules/secrets-management.md)
- [OWASP Secrets Management](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html)

---

## What Gets Checked

### MD040 - Fenced Code Language

**Rule**: Every code block MUST have a language tag.

**Wrong:**

```text
code without language
```

**Correct:**

```javascript
const x = 1;
```

**Common tags:**

| Language | Tags |
| -------- | ---- |
| Shell scripts | `bash`, `sh` |
| JavaScript | `javascript`, `js` |
| TypeScript | `typescript`, `ts` |
| Python | `python`, `py` |
| JSON | `json` |
| YAML | `yaml`, `yml` |
| SQL | `sql` |
| Web | `html`, `css` |
| Markdown | `markdown`, `md` |
| Default (unsure) | `markdown` |

### MD060 - Table Formatting

**Rule**: Table separators need proper spacing.

**Wrong:**

```markdown
| Header |
|--------|
```

**Correct:**

```markdown
| Header |
| ------ |
```

### TypeScript/JavaScript Linting

If `package.json` has a `lint` script, TypeScript and JavaScript files are checked:

```bash
npm run lint
```

---

## Best Practices

### 1. Install Early

Set up lefthook immediately after creating a project:

```bash
./scripts/setup-project.sh --name project --tools claude --git
cd project
lefthook install
```

### 2. Commit Configuration

Add hook config to version control:

```bash
git add lefthook.yml .lefthookrc.json .markdownlint.json
git commit -m "Add git hooks configuration"
```

### 3. Update Hooks

When updating hook commands:

```bash
# Edit lefthook.yml, then reinstall
lefthook install
```

### 4. Team Consistency

Ensure all team members use the same version:

```bash
# Add to package.json
"devDependencies": {
  "@evilmartians/lefthook": "^1.7.0"
}

npm install
lefthook install
```

### 5. Document Exceptions

When disabling rules, document why:

```markdown
<!-- markdownlint-disable MD033 -->
<!-- Reason: Custom HTML for styling needed -->
<div class="custom-style">Content</div>
<!-- markdownlint-enable MD033 -->
```

---

## Advanced Configuration

### Conditional Hooks

Run hooks only when conditions are met:

```yaml
pre-commit:
  commands:
    typescript-lint:
      glob: "*.{ts,tsx}"
      run: npx tsc --noEmit
      only: "*.{ts,tsx}"  # Only if TypeScript files changed
```

### Stage Fixed Files

Auto-stage files that hooks fix:

```yaml
pre-commit:
  commands:
    markdown-lint:
      glob: "*.md"
      run: markdownlint --fix {staged_files}
      stage_fixed: true  # Auto-stage fixed files
```

### Skip Output

Reduce noise in console:

```yaml
pre-commit:
  commands:
    lint:
      run: npm run lint
      skip_output: [execution_info]  # Hide execution info
```

### Environment Variables

Pass environment data to hooks:

```yaml
pre-commit:
  commands:
    check:
      run: echo $LEFTHOOK_HOOK_NAME
      # Available: LEFTHOOK_HOOK_NAME, LEFTHOOK_RESULT, etc.
```

---

## Comparison: Lefthook vs. Bash Scripts

| Feature | Lefthook | Bash Scripts |
| ------- | -------- | ------------ |
| **Speed** | ⚡ Fast (compiled) | 🐌 Slower |
| **Cross-platform** | ✅ Works everywhere | ❌ Unix-only |
| **Configuration** | 📝 YAML (simple) | 🔧 Bash (complex) |
| **Parallel execution** | ✅ Built-in | ❌ Manual |
| **Maintenance** | ✅ Easy | ❌ Hard |
| **Dependencies** | Single binary | Bash interpreter |
| **Learning curve** | ✅ Low | ❌ High |

---

## Related Documentation

- [Markdown Linting Rule](./../.claude/rules/markdown-linting.md)
- [Markdown Linter Skill](./../.claude/skills/markdown-linter/README.md)
- [Project Setup Guide](./SETUP_GUIDE.md)
- [Lefthook Official Docs](https://github.com/evilmartians/lefthook)

---

## Support

**Lefthook Documentation:**

- [GitHub: evilmartians/lefthook](https://github.com/evilmartians/lefthook)
- [Official Wiki](https://github.com/evilmartians/lefthook/wiki)

**Markdownlint Documentation:**

- [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli)

For issues with project setup, see [Troubleshooting](#troubleshooting) above.

---

**Last Updated**: 2026-01-15
