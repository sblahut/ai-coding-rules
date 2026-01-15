# Project Guidelines for Antigravity AI

This file contains project-specific guidelines for Antigravity AI assistant.

## Project Overview

- **Name:** [Your Project Name]
- **Purpose:** [What this project does]
- **Tech Stack:** [Languages, frameworks, tools]

## Repository Structure

[Describe your project structure]

## Development Setup

- **Dependencies:** [How to install]
- **Environment:** [Local dev setup]
- **Testing:** [How to run tests]

## Coding Standards

- Follow the rules in `.agent/rules/`
- Use TDD workflow from `.agent/workflows/tdd-workflow.md`
- TypeScript: No `any`, prefer `interface`
- Markdown: All code blocks must have language tags (MD040)

## Available Workflows

Trigger workflows using their defined trigger commands:

| Workflow | Trigger | Description |
| -------- | ------- | ----------- |
| Feature Flag | `/feature` | Scaffold new features with safety flags |
| Commit & Push | Manual | Generate conventional commits and push |
| MR Description | Manual | Generate merge request descriptions |
| TDD Workflow | Manual | Red-Green-Verify development loop |
| Code Analyzer | Manual | Comprehensive code quality analysis |
| Markdown Linter | Manual | Validate and fix markdown files |

## Common Commands

- Tests: `npm run test`
- Build: `npm run build`
- Lint: `npm run lint`
- Markdown Lint: `npm run lint:md`

## Getting Help

Refer to `.agent/rules/` for coding standards and `.agent/workflows/` for development procedures.
