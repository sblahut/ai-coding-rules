# Agent Coding Standards Overview

> **Trigger:** Always-on (applies to all TypeScript/JavaScript operations)
> **Applies to:** `**/*.ts`, `**/*.tsx`, `**/*.js`, `**/*.jsx`, `**/*.py`, `**/*.java`, `**/*.cs`, `**/*.go`

This document provides an overview of coding practices. For comprehensive, AI agent standards, refer to the detailed guides below.

## Agent Standards

**Location:** `.agent/rules/coding-standards.mdc`
**Focus:** Enterprise-grade, maintainable, strictly typed code with SOLID principles
**Best For:** General AI assistants requiring comprehensive architectural guidance

## Core Principles (Agent Standards)

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

All agent standards enforce:
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

## Available Agent Rules

| Rule | Description |
|------|-------------|
| `coding-standards.mdc` | Comprehensive agent coding standards |
| `markdown-linting.md` | Markdown formatting and linting standards |

## Additional Resources

- **Claude Standards:** `.claude/rules/` for AI-assisted development
- **Cursor Standards:** `.cursor/rules/` for IDE-integrated development
- **Project Instructions:** `.cursor/rules/project-instructions.mdc`

**Note:** Always refer to the comprehensive standards in `.agent/rules/coding-standards.mdc` for detailed AI agent implementation guidance.
