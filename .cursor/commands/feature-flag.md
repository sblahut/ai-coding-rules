# Feature Flag Scaffold Command

Scaffolds a new feature with safety flags (CDK infrastructure) and prepares the TDD loop.

## Usage

Invoke this command when creating new features that need feature flag protection.

## Protocol

### Phase 1: The Safety Layer (Infrastructure)

1. **Name the Flag**
   - Format: `features.<component>.<action>_enabled`
   - Example: `features.auth.cognito_enabled`

2. **Update Config Interface** (`infrastructure/lib/types/environment.ts`)
   - Add the new flag definition to `EnvironmentConfig` interface
   - Use TSDoc comment to document the flag

3. **Enable in Sandbox** (`infrastructure/lib/config/sandbox.ts`)
   - Set flag to `true` in sandbox environment only
   - Do NOT enable in dev, stage, or prod

### Phase 2: CDK Implementation

1. **Locate Stack** - Find relevant stack in `infrastructure/lib/stacks/`

2. **Read Flag** - Read flag from config in stack constructor:

   ```typescript
   const isFeatureEnabled = props.config.features?.component?.feature_enabled;
   ```

3. **Conditional Logic** - Wrap resources in conditional block:

   ```typescript
   if (isFeatureEnabled) {
     // Create resources only when flag is true
   }
   ```

### Phase 3: Application Handoff

1. **Pass Configuration** - Use environment variables:

   ```typescript
   environment: {
     FEATURE_ENABLED: isFeatureEnabled ? 'true' : 'false',
     RESOURCE_ID: isFeatureEnabled ? resource.id : '',
   }
   ```

2. **Handle Missing Resources** - Application must handle gracefully:

   ```typescript
   if (process.env.FEATURE_ENABLED === 'true') {
     // Use feature
   } else {
     // Fallback behavior
   }
   ```

### Phase 4: TDD Handoff

Once infrastructure is ready, ask the user:

> "Feature flags and infrastructure shells are ready. Shall we enable this locally and start the TDD loop?"

## Checklist

- [ ] Flag key follows naming convention
- [ ] Interface updated with TSDoc comment
- [ ] Sandbox config enables the flag
- [ ] Other environments do NOT enable the flag
- [ ] CDK stack reads flag from config
- [ ] Resources wrapped in conditional blocks
- [ ] Environment variables pass flag state
- [ ] Application handles missing resources

## Key Principle

**No application logic until infrastructure is ready.**

Order: Define flag -> Enable sandbox -> Wrap CDK -> Pass config -> Handle gracefully -> Start TDD
