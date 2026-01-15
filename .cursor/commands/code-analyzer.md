# Code Analyzer Command

Comprehensive code analysis for quality, performance, security, and architectural patterns.

## Usage

Invoke this command when reviewing code, refactoring, or analyzing design decisions.

## Analysis Dimensions

### 1. Correctness (CRITICAL -> HIGH)

- Logic errors and infinite loops
- Null/undefined access without checks
- Off-by-one errors
- Edge cases not handled
- State consistency issues

### 2. Security (CRITICAL -> MEDIUM)

- SQL/Command injection vulnerabilities
- Cross-site scripting (XSS)
- Sensitive data exposure
- Broken authentication/authorization
- Insecure deserialization

### 3. Performance (HIGH -> MEDIUM)

- Algorithm complexity (O(n²) problems)
- N+1 database queries
- Memory leaks
- Unnecessary iterations
- Blocking operations

### 4. Maintainability (MEDIUM -> LOW)

- Variable naming clarity
- Function length (>50 lines is a smell)
- Magic numbers/strings
- DRY violations
- SOLID principles adherence

### 5. Testability (MEDIUM -> LOW)

- Pure vs impure functions
- Dependency injection patterns
- Mock-ability of dependencies
- Setup complexity

### 6. Architecture (HIGH -> MEDIUM)

- Separation of concerns
- Coupling between modules
- Design pattern usage
- Extensibility

## Severity Levels

| Level | Description | Action |
| ----- | ----------- | ------ |
| CRITICAL | Code breaks, security vulnerability | Must fix |
| HIGH | Significant bug, major perf issue | Should fix |
| MEDIUM | Design flaw, clarity issue | Consider |
| LOW | Minor inefficiency | Optional |
| INFO | Learning opportunity | Awareness |

## Output Format

Provide analysis as:

```markdown
## Code Analysis Report

### Summary
- Language: [detected]
- Issues: [count by severity]

### Critical Issues
[Line numbers + specific fixes]

### High Priority
[Line numbers + recommendations]

### Medium/Low
[Suggestions for improvement]

### Recommendations
[Actionable next steps]
```

## Common Issues to Watch

### TypeScript (Project Rule: No `any`)

```typescript
// WRONG
function process(data: any) { return data.value; }

// CORRECT
function process(data: unknown) {
  if (typeof data === 'object' && data !== null && 'value' in data) {
    return (data as { value: string }).value;
  }
  throw new Error("Invalid data format");
}
```

### Unhandled Promises

```typescript
// WRONG
fetch('/api/data').then(processData);

// CORRECT
try {
  const response = await fetch('/api/data');
  if (!response.ok) throw new Error(`HTTP ${response.status}`);
  return await response.json();
} catch (error) {
  console.error('Failed to fetch', error);
  throw error;
}
```

## Checklist

- [ ] Logic errors identified
- [ ] Security vulnerabilities scanned
- [ ] Performance assessed
- [ ] Maintainability evaluated
- [ ] Testability noted
- [ ] Architecture reviewed
- [ ] Issues prioritized by severity
- [ ] Actionable fixes provided
