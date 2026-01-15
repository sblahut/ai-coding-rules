# Markdown Linter Command

Validate and fix markdown files against project linting standards.

## Usage

Invoke this command when checking or fixing markdown files.

## Mandatory Rules

### MD040 - Fenced Code Blocks

Every code block MUST have a language identifier.

````markdown
# WRONG - Missing language tag
```
code here
```

# CORRECT - Has language tag
```javascript
code here
```
````

**Default:** Use `markdown` if unsure of the correct language.

### MD060 - Table Column Spacing

Table separator rows must have spaces around pipes.

```markdown
# WRONG
| Header |
|--------|

# CORRECT
| Header |
| ------ |
```

## Language Tags

| Content | Tag |
| ------- | --- |
| Shell scripts | `bash` |
| JavaScript | `javascript` |
| TypeScript | `typescript` |
| Python | `python` |
| JSON | `json` |
| YAML | `yaml` |
| SQL | `sql` |
| HTML | `html` |
| CSS | `css` |
| Docker | `dockerfile` |
| Git diffs | `diff` |
| Unsure | `markdown` |

## Linting Steps

1. **Identify Issues**
   - Code blocks without language tags
   - Tables with improper spacing
   - Missing blank lines

2. **Fix Code Blocks**
   - Add appropriate language identifier
   - Default to `markdown` if uncertain

3. **Fix Tables**
   - Ensure separator uses spaces: `| ------ |`

4. **Fix Formatting**
   - Add blank lines around headers
   - Fix list indentation

5. **Verify**

   ```bash
   npm run lint:md
   ```

## Output Format

```markdown
## Markdown Linting Report

### Issues Found
- MD040: [count] code blocks missing language tags
- MD060: [count] tables with spacing issues

### Fixes Applied
- Added language tags to [n] code blocks
- Fixed [n] table separators

### Result
Status: PASS / FAIL
```

## Checklist

- [ ] All code blocks have language tags
- [ ] Table separators have spaces around pipes
- [ ] Blank lines before/after headers
- [ ] Lists properly indented
