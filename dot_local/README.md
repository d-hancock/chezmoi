# Local Directory (dot_local)

## Overview

This directory contains user-specific scripts, binaries, and data that will be placed in `~/.local/` by ChezMoi. It follows the XDG Base Directory specification and provides a structured location for custom tools and scripts.

### Role in the Project

The `dot_local` directory serves as your personal toolkit extension:
- **Scripts**: Custom utilities and workflow automation
- **Binaries**: User-compiled or downloaded executables
- **Data**: Application-specific data files
- **Integration**: Scripts in `bin/` are automatically available on `$PATH`

### Integration with Other Components

- **Shell Integration**: `~/.local/bin` is added to `$PATH` by most modern shells
- **Tool Chain**: Custom scripts can complement Pixi-managed tools
- **Workflow**: Scripts can automate common development tasks
- **Portability**: User scripts travel with your dotfiles across machines

---

## Directory Structure

### `bin/` - Executable Scripts
- **Purpose**: Custom scripts and utilities for personal workflow
- **Path Integration**: Automatically available on `$PATH`
- **Examples**: Development shortcuts, system utilities, project helpers
- **Format**: Shell scripts, Python scripts, compiled binaries

### Current Contents
- **`sample-script.sh`**: Template for creating new scripts
- Ready to be replaced with your own utilities

---

## Script Development

### Creating New Scripts
1. **Add Script**: Create new file in `bin/` directory
   ```bash
   chezmoi edit ~/.local/bin/my-script.sh
   ```

2. **Set Permissions**: Make executable
   ```bash
   chmod +x ~/.local/bin/my-script.sh
   ```

3. **Test**: Script should be available immediately
   ```bash
   my-script.sh
   ```

### Script Categories
Consider organizing scripts by purpose:
- **Development**: Git helpers, project setup, build automation
- **System**: File management, system monitoring, maintenance
- **Data**: Processing scripts, backup utilities, sync tools
- **Workflow**: Task automation, template generation, shortcuts

### Best Practices
- **Naming**: Use clear, descriptive names with appropriate extensions
- **Documentation**: Include usage comments and help text
- **Error Handling**: Add proper error checking and user feedback
- **Dependencies**: Document any required tools or libraries
- **Portability**: Consider different environments and OS variations

---

## Examples and Templates

### Sample Script Structure
```bash
#!/usr/bin/env bash
# Description: Brief description of what this script does
# Usage: script-name [options] [arguments]
# Dependencies: list any required tools

set -euo pipefail  # Exit on error, undefined vars, pipe failures

# Configuration
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_NAME="$(basename "$0")"

# Functions
show_help() {
    cat << EOF
Usage: $SCRIPT_NAME [OPTIONS]

Description of what this script does.

OPTIONS:
    -h, --help     Show this help message
    -v, --verbose  Enable verbose output

EXAMPLES:
    $SCRIPT_NAME --verbose
EOF
}

main() {
    # Your script logic here
    echo "Hello from $SCRIPT_NAME"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -v|--verbose)
            set -x
            shift
            ;;
        *)
            echo "Unknown option: $1" >&2
            show_help >&2
            exit 1
            ;;
    esac
done

main "$@"
```

### Integration Examples
- **Git Workflow**: Scripts for branch management, commit templates
- **Project Setup**: Initialize new projects with standard structure
- **System Maintenance**: Update all tools, clean caches, backup configs
- **Development**: Build automation, test runners, deployment helpers

---

## Management and Deployment

### Adding Scripts
1. **Create**: Add script to `dot_local/bin/`
2. **Test Locally**: Verify script works in current environment
3. **Apply**: Use `chezmoi apply` to deploy to `~/.local/bin`
4. **Version Control**: Commit changes to dotfiles repository

### Sharing Scripts
Scripts in this directory are automatically shared across all machines where you deploy your dotfiles, making them perfect for:
- Personal productivity tools
- Development workflow automation
- System administration helpers
- Cross-platform utilities

### Security Considerations
- **Review Code**: Ensure scripts don't contain sensitive information
- **Permissions**: Be mindful of script permissions and capabilities
- **Dependencies**: Document external tool requirements
- **Testing**: Test scripts in clean environments before deployment
