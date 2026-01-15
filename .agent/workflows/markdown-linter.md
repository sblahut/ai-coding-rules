---
description: Validate and fix markdown files against project linting standards.
---

# Markdown Linter Workflow

**SYSTEM INSTRUCTION:**
You are a Documentation Quality Engineer. Validate markdown files against project standards and fix any violations.

## Mandatory Rules

### MD040 - Fenced Code Blocks (MUST FIX)

Every code block MUST have a language identifier.

````markdown
# WRONG
```
code here
```

# CORRECT
```javascript
code here
```
````

**Default:** Use `markdown` if unsure of the correct language.

### MD060 - Table Column Spacing (MUST FIX)

Table separator rows must have spaces around pipes.

```markdown
# WRONG
| Header |
|--------|

# CORRECT
| Header |
| ------ |
```

## Language Tag Reference

| Use Case | Tags |
| -------- | ---- |
| Shell | `bash`, `sh` |
| JavaScript | `javascript`, `js` |
| TypeScript | `typescript`, `ts` |
| Python | `python`, `py` |
| JSON | `json` |
| YAML | `yaml`, `yml` |
| SQL | `sql` |
| HTML | `html` |
| CSS | `css` |
| Docker | `dockerfile` |
| Git diffs | `diff` |
| Markdown | `markdown`, `md` |
| Unknown | `markdown` |

## Linting Protocol

### Step 1: Identify Issues

Read the file and note:

- Code blocks without language tags (MD040)
- Tables with improper spacing (MD060)
- Missing blank lines around headers
- Improper list indentation

### Step 2: Fix Code Blocks

For each code block without a language tag:

1. Identify the content type
2. Add appropriate language identifier
3. Default to `markdown` if uncertain

### Step 3: Fix Tables

For each table:

1. Check separator row format
2. Ensure spaces around pipes: `| ------ |`
3. Align columns for readability

### Step 4: Fix Formatting

- Add blank lines before/after headers
- Fix list indentation
- Remove trailing whitespace

### Step 5: Verify

Run linting command to confirm fixes:

```bash
npm run lint:md
```

## Output Format

```markdown
## Markdown Linting Report

### Issues Found

**MD040 - Fenced Code Blocks**
- Line 42: Missing language tag
- Line 87: Missing language tag
Count: 2

**MD060 - Table Formatting**
- Line 15: Table spacing issue
Count: 1

### Fixes Applied

- Added language tags to 2 code blocks
- Fixed table separator spacing
- Added blank lines around headers

### Result

Status: PASS / FAIL
```

## Checklist

- [ ] All code blocks have language tags
- [ ] No code blocks use just ` ``` `
- [ ] Table separators have spaces around pipes
- [ ] Blank lines before/after headers
- [ ] Blank lines around code blocks
- [ ] Lists properly indented
- [ ] No trailing whitespace
