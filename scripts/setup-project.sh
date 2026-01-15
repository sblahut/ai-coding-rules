#!/bin/bash

###############################################################################
# setup-project.sh - Bootstrap a new project with AI coding templates
#
# Usage:
#   ./setup-project.sh --name my-project --tools claude,cursor,antigravity
#   ./setup-project.sh --name my-project --tools all
#   ./setup-project.sh (interactive mode)
###############################################################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Defaults
PROJECT_NAME=""
TOOLS=""
TARGET_PATH="."
INIT_GIT=0
INTERACTIVE=1

###############################################################################
# Helper Functions
###############################################################################

print_header() {
  echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
  echo -e "${BLUE}$1${NC}"
  echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
}

print_success() {
  echo -e "${GREEN}✓${NC} $1"
}

print_error() {
  echo -e "${RED}✗${NC} $1"
}

print_warning() {
  echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
  echo -e "${BLUE}ℹ${NC} $1"
}

usage() {
  cat << EOF
${BLUE}AI Coding Templates - Project Setup${NC}

${YELLOW}Usage:${NC}
  $(basename "$0") --name PROJECT_NAME --tools TOOLS [OPTIONS]
  $(basename "$0") [interactive mode if no args]

${YELLOW}Options:${NC}
  --name PROJECT_NAME        Project name (required)
  --tools TOOLS              Tools to setup (comma-separated or 'all')
                             Options: claude,cursor,antigravity,gemini,all
  --path PATH                Directory to create project in (default: current)
  --git                      Initialize git repository
  --help                     Show this help message

${YELLOW}Examples:${NC}
  # Setup with Claude only
  $(basename "$0") --name my-project --tools claude

  # Setup with all tools
  $(basename "$0") --name my-project --tools all --git

  # Setup in specific directory
  $(basename "$0") --name my-project --tools claude,cursor --path ~/projects

  # Interactive mode
  $(basename "$0")

EOF
}

parse_arguments() {
  while [[ $# -gt 0 ]]; do
    case $1 in
      --name)
        PROJECT_NAME="$2"
        shift 2
        ;;
      --tools)
        TOOLS="$2"
        shift 2
        ;;
      --path)
        TARGET_PATH="$2"
        shift 2
        ;;
      --git)
        INIT_GIT=1
        shift
        ;;
      --help)
        usage
        exit 0
        ;;
      *)
        print_error "Unknown option: $1"
        usage
        exit 1
        ;;
    esac
  done
}

interactive_mode() {
  print_header "AI Coding Templates - Interactive Setup"

  # Get project name
  while [[ -z "$PROJECT_NAME" ]]; do
    read -p "Project name: " PROJECT_NAME
    if [[ -z "$PROJECT_NAME" ]]; then
      print_error "Project name cannot be empty"
    fi
  done

  # Get tools
  while [[ -z "$TOOLS" ]]; do
    echo ""
    echo "Select tools to include:"
    echo "  1) Claude only"
    echo "  2) Cursor only"
    echo "  3) Antigravity only"
    echo "  4) Gemini only"
    echo "  5) All (Claude + Cursor + Antigravity + Gemini)"
    read -p "Choice [1-5]: " choice

    case $choice in
      1) TOOLS="claude" ;;
      2) TOOLS="cursor" ;;
      3) TOOLS="antigravity" ;;
      4) TOOLS="gemini" ;;
      5) TOOLS="all" ;;
      *) print_error "Invalid choice" ;;
    esac
  done

  # Ask about git
  read -p "Initialize git repository? [y/N]: " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    INIT_GIT=1
  fi

  INTERACTIVE=0
}

validate_inputs() {
  if [[ -z "$PROJECT_NAME" ]]; then
    print_error "Project name is required"
    usage
    exit 1
  fi

  if [[ -z "$TOOLS" ]]; then
    print_error "Tools selection is required"
    usage
    exit 1
  fi

  # Expand "all" to all tools
  if [[ "$TOOLS" == "all" ]]; then
    TOOLS="claude,cursor,antigravity,gemini"
  fi

  # Validate tool names
  IFS=',' read -ra TOOL_ARRAY <<< "$TOOLS"
  for tool in "${TOOL_ARRAY[@]}"; do
    tool=$(echo "$tool" | xargs) # trim whitespace
    if [[ ! "$tool" =~ ^(claude|cursor|antigravity|gemini)$ ]]; then
      print_error "Invalid tool: $tool"
      exit 1
    fi
  done
}

create_project() {
  local project_path="$TARGET_PATH/$PROJECT_NAME"

  # Check if directory already exists
  if [[ -d "$project_path" ]]; then
    print_error "Directory already exists: $project_path"
    exit 1
  fi

  print_info "Creating project directory: $project_path"
  mkdir -p "$project_path"

  # Copy shared files
  print_info "Adding shared configuration..."
  cp "$SCRIPT_DIR/.gitignore" "$project_path/"

  # Process each tool
  IFS=',' read -ra TOOL_ARRAY <<< "$TOOLS"
  for tool in "${TOOL_ARRAY[@]}"; do
    tool=$(echo "$tool" | xargs) # trim whitespace

    case $tool in
      claude)
        print_info "Adding Claude configuration..."
        cp -r "$SCRIPT_DIR/.claude" "$project_path/"
        print_success "Added .claude/"
        ;;
      cursor)
        print_info "Adding Cursor configuration..."
        cp -r "$SCRIPT_DIR/.cursor" "$project_path/"
        print_success "Added .cursor/"
        ;;
      antigravity)
        print_info "Adding Antigravity configuration..."
        cp -r "$SCRIPT_DIR/.agent" "$project_path/"
        print_success "Added .agent/"
        ;;
    esac
  done
}

create_readme() {
  local project_path="$TARGET_PATH/$PROJECT_NAME"
  local readme="$project_path/README.md"

  cat > "$readme" << 'EOF'
# Project Setup

This project was created using [ai-coding-templates](https://github.com/your-org/ai-coding-templates).

## AI Coding Assistant Setup

This project includes configuration for AI coding assistants. Configure the following as needed:

### Claude Code
- Location: `.claude/`
- **config.json** - Enable/disable plugins for this project
- **rules/** - Coding standards and linting rules
- **instructions.md** - Project-specific guidelines (edit as needed)
- **skills/** - Optional project-specific skills (n8n workflows)

### Cursor
- Location: `.cursor/`
- **rules/** - Rules for Cursor (use `.mdc` format)
- **commands/** - Custom commands for Cursor

### Antigravity
- Location: `.agent/`
- **rules/** - AI agent rules
- **workflows/** - Automated workflows

## Getting Started

1. Edit project-specific configuration:
   - `.claude/instructions.md` - Add your project guidelines
   - `.claude/config.json` - Add project-specific plugins
   - `.cursor/rules/` - Customize rules as needed
   - `.agent/rules/` - Customize agent rules

2. Initialize version control:
   ```bash
   git init
   git add .
   git commit -m "Initial commit with AI coding templates"
   ```

3. Start developing with your favorite AI coding assistant!

## Documentation

- **Claude Code**: See `.claude/rules/` for standards
- **Cursor**: See `.cursor/rules/` for configuration
- **Antigravity**: See `.agent/rules/` for workflows

## Template Updates

To update templates or sync with latest:
```bash
# Review changes from ai-coding-templates
cp -r /path/to/ai-coding-templates/[tool]/project-config/.* ./
```

---

Generated with [ai-coding-templates](https://github.com/your-org/ai-coding-templates)
EOF

  print_success "Created README.md"
}

init_git_repo() {
  local project_path="$TARGET_PATH/$PROJECT_NAME"

  if [[ $INIT_GIT -eq 1 ]]; then
    print_info "Initializing git repository..."
    cd "$project_path"
    git init

    # Setup git-secrets if available
    if command -v git-secrets &> /dev/null; then
      print_info "Configuring git-secrets..."
      git secrets --install --force
      git secrets --register-aws

      # Add custom patterns
      git secrets --add 'private_key'
      git secrets --add 'api[_-]?key'
      git secrets --add 'api[_-]?secret'
      git secrets --add 'access[_-]?token'
      git secrets --add '[a-zA-Z0-9_-]*password[a-zA-Z0-9_-]*\s*[:=]'
      git secrets --add -- '-----BEGIN (RSA|DSA|EC|OPENSSH|PGP) PRIVATE KEY'

      print_success "git-secrets configured with AWS and custom patterns"
    else
      print_warning "git-secrets not found - install with: brew install git-secrets"
      print_warning "Secrets scanning will be skipped until installed"
    fi

    git add .
    git commit -m "Initial commit: AI coding templates setup" || true
    cd - > /dev/null
    print_success "Git repository initialized"
  fi
}

print_summary() {
  local project_path="$TARGET_PATH/$PROJECT_NAME"

  echo ""
  print_header "Project Created Successfully!"
  echo ""
  print_success "Project: $PROJECT_NAME"
  print_success "Location: $project_path"
  print_success "Tools: $TOOLS"
  echo ""

  echo -e "${YELLOW}Next Steps:${NC}"
  echo "  1. cd $project_path"
  echo "  2. Install git-secrets: brew install git-secrets (if not installed)"
  echo "  3. lefthook install (set up git hooks)"
  echo "  4. Edit .claude/instructions.md (Claude users)"
  echo "  5. Customize .claude/config.json to add plugins"
  echo "  6. Review and edit tool-specific rules"
  echo "  7. git add . && git commit -m 'Customize AI settings'"
  echo ""

  echo -e "${YELLOW}Security Setup (Secrets Protection):${NC}"
  echo "  • Install git-secrets: brew install git-secrets"
  echo "  • git-secrets auto-configured in new projects (if installed)"
  echo "  • Blocks commits with AWS keys, API keys, passwords"
  echo "  • See docs/GIT_HOOKS.md for secrets scanning details"
  echo ""

  echo -e "${YELLOW}Git Hooks (Lefthook):${NC}"
  echo "  1. Install lefthook:"
  echo "     npm install -g @evilmartians/lefthook"
  echo "     or: brew install lefthook"
  echo "  2. Setup hooks: lefthook install"
  echo "  3. See docs/GIT_HOOKS.md for details"
  echo ""

  echo -e "${YELLOW}Quick Reference:${NC}"
  if [[ "$TOOLS" == *"claude"* ]]; then
    echo "  Claude: .claude/config.json (plugins) | .claude/rules/ (standards)"
  fi
  if [[ "$TOOLS" == *"cursor"* ]]; then
    echo "  Cursor: .cursor/rules/ | .cursor/commands/"
  fi
  if [[ "$TOOLS" == *"antigravity"* ]]; then
    echo "  Antigravity: .agent/rules/ | .agent/workflows/"
  fi
  echo ""

  echo -e "${BLUE}Documentation:${NC}"
  echo "  • Template Repo: $SCRIPT_DIR"
  echo "  • README.md: $project_path/README.md"
  echo ""
}

###############################################################################
# Main
###############################################################################

main() {
  # Parse command line arguments
  if [[ $# -eq 0 ]]; then
    interactive_mode
  else
    INTERACTIVE=0
    parse_arguments "$@"
  fi

  # Validate inputs
  validate_inputs

  print_header "Setting up: $PROJECT_NAME"

  # Create project
  create_project

  # Create README
  create_readme

  # Initialize git
  init_git_repo

  # Print summary
  print_summary
}

main "$@"
