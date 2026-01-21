# Claude Coding Standards Overview

> **Trigger:** Always-on (applies to all TypeScript/JavaScript operations)
> **Applies to:** `**/*.ts`, `**/*.tsx`, `**/*.js`, `**/*.jsx`, `**/*.py`, `**/*.java`, `**/*.cs`, `**/*.go`

This document provides an overview of coding practices. For comprehensive, Claude-specific standards, refer to the detailed guides below.

## Claude-Specific Standards

**Location:** `.claude/rules/coding-standards.mdc`
**Focus:** AI-assisted development with architectural analysis and self-critique protocols
**Best For:** Claude-specific development with advanced AI capabilities

## Core Principles (Claude Standards)

### Strict Type Safety: Zero Tolerance for `any`

**NEVER use the `any` type in TypeScript.**

- Use `unknown` for uncertain inputs with proper type guards
- Implement comprehensive validation (Zod, custom guards)
- Leverage TypeScript's type system for safety

**❌ Incorrect:**
```typescript
function processData(data: any) {
  return data.value; // Unsafe access
}
```

**✅ Correct:**
```typescript
function processData(data: unknown) {
  if (isValidData(data)) {
    return data.value; // Safe access with validation
  }
  throw new Error("Invalid data format");
}

function isValidData(data: unknown): data is { value: string } {
  return typeof data === 'object' &&
         data !== null &&
         'value' in data &&
         typeof (data as any).value === 'string';
}
```

### SOLID Principles Implementation

All Claude standards enforce:
- **SRP:** Single responsibility per function/class
- **OCP:** Open for extension, closed for modification
- **LSP:** Subtypes substitutable for base types
- **ISP:** Client-specific interfaces
- **DIP:** Depend on abstractions, not concretions

### Development Workflow

1. **Analysis:** Review existing architecture and patterns
2. **Planning:** Design with SOLID principles and clean architecture
3. **Implementation:** Write strictly typed, testable code
4. **Validation:** Self-critique against standards before output
5. **Refactoring:** Improve structure when needed

## Available Claude Rules

| Rule | Description |
|------|-------------|
| `coding-standards.mdc` | Comprehensive Claude-specific coding standards |
| `tdd-workflow.md` | Test-Driven Development workflow guidelines |
| `markdown-linting.md` | Markdown formatting and linting standards |
| `secrets-management.md` | Security practices for handling secrets |

## Additional Resources

- **Cursor Standards:** `.cursor/rules/` for IDE-integrated development
- **Agent Standards:** `.agent/rules/` for general AI agent standards
- **Project Instructions:** `.cursor/rules/project-instructions.mdc`

**Note:** Always refer to the comprehensive standards in `.claude/rules/coding-standards.mdc` for detailed Claude-specific implementation guidance.
