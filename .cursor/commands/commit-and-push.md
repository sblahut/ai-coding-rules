# Commit and Push Changes

Generates a Conventional Commit message based on staged changes, commits them, and pushes to remote.

## Instructions

1. Analyze the staged changes:

   ```bash
   git diff --staged
   ```

   - If no files are staged, **ASK the user to stage files first** and stop.

2. Generate a "Conventional Commits" message following the format `<type>(<scope>): <subject>`:
   - Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`
   - Subject: Imperative mood, < 50 chars
   - Body: Bullet points if complex

3. Execute the commit:

   ```bash
   git commit -m "YOUR_GENERATED_MESSAGE"
   ```

   - **CRITICAL**: Set `SafeToAutoRun` to `false` so the user can review the message.

4. Execute the push:

   ```bash
   git push
   ```

   - **CRITICAL**: Set `SafeToAutoRun` to `false`.
   - Verify the commit was successful before pushing.

## Guidelines

- **Message Format**: `<type>(<scope>): <subject>`
  - Example: `feat(auth): add google login support`
  - Example: `fix(api): resolve timeout in data fetching`
- **Scope**: Optional but recommended (e.g., `feature-name`, `file-name`, `module`).
- **Subject**: Use imperative mood ("add" not "added" or "adds").
- **Body**: Use if the change needs more context than the subject line allows.
- **Verification**: Always ensure the commit command succeeds before attempting to push.
