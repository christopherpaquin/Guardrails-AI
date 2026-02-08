# 🛡️ AI Guardrails for Engineering Projects

Universal AI coding assistant configurations and guardrails for professional software engineering.

[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
[![AI-Friendly](https://img.shields.io/badge/AI-Cursor%20%7C%20Claude%20%7C%20Copilot-green.svg)](CLAUDE.md)
[![Quality](https://img.shields.io/badge/quality-enforced-brightgreen.svg)](.pre-commit-config.yaml)

---

## 🎯 What Is This?

**AI Guardrails** provides tool-specific configuration files that teach AI coding assistants
(Cursor, Claude, GitHub Copilot, etc.) to follow engineering best practices for:

- 🔒 **Security**: Never commit secrets, enforce proper credential handling

- ✅ **Quality**: Enforce code formatting, linting, and style standards

- 📝 **Documentation**: Maintain clear, up-to-date documentation

- 🛡️ **Safety**: Idempotent scripts, proper error handling, input validation

---

## 🚀 Quick Start

### For New Projects

```bash
# Clone into your project
cd your-project
git clone <this-repo-url> .ai-guardrails

# Copy AI configurations
cp .ai-guardrails/.cursor/ . -r          # For Cursor
cp .ai-guardrails/CLAUDE.md .            # For Claude Desktop
cp .ai-guardrails/CONTRIBUTING.md .      # For all contributors
cp .ai-guardrails/.claudeprompt .        # For Claude Projects
cp .ai-guardrails/.continue/ . -r        # For Continue.dev
cp .ai-guardrails/.windsurfignore .      # For Windsurf
cp .ai-guardrails/.vscode/ . -r          # For VS Code/Windsurf

# Setup is complete! AI assistants will now follow the standards.
```

### For Existing Projects

```bash
# Add as a git submodule (recommended)
git submodule add <this-repo-url> .ai-guardrails

# Reference from your project
ln -s .ai-guardrails/.cursor .cursor
ln -s .ai-guardrails/CLAUDE.md CLAUDE.md
```

---

## 📂 Repository Structure

This repository has two main parts:

### 1. AI Context Files (Root Directory)

These files teach AI tools about your standards. Copy them to your projects:

- **`.cursor/rules/*.mdc`** - Cursor AI rules (8 scoped, prioritized files)

- **`CLAUDE.md`** - Claude Desktop comprehensive instructions

- **`.claudeprompt`** - Claude Projects single-line config

- **`.github/copilot-instructions.md`** - GitHub Copilot format

- **`.aider/.aider.conf.yml`** - Aider configuration

- **`.continue/config.yaml`** - Continue.dev agent config (rules, prompts, context)

- **`.windsurfignore`** - Windsurf context exclusions (files to ignore)

- **`.vscode/settings.json`** - VS Code/Windsurf editor settings

- **`CONTEXT.md`** - Canonical standards document (source of truth)

- **`CONTRIBUTING.md`** - Guidelines for all contributors

### 2. Template Infrastructure (template/ Directory)

Pre-commit hooks, CI/CD workflows, and management scripts. Use the bootstrap script to copy to your project:

```bash
./template/bootstrap-guardrails.sh
```

**Infrastructure includes:**

- **Pre-commit framework** (20+ quality and security hooks)

- **CI/CD workflows** (GitHub Actions for testing and security scanning)

- **Security scripts** (secret detection, commit message validation)

- **Management scripts** (setup, enable/disable hooks and jobs)

- **Comprehensive documentation**

See `template/TEMPLATE_STRUCTURE.md` for complete details.

---

## 🛠️ Management Scripts

The template includes powerful management scripts:

### Setup Pre-commit

```bash
./scripts/setup-precommit.sh
```

Installs and configures pre-commit hooks automatically.

### Manage Hooks

```bash
# List all hooks
./scripts/manage-precommit-hooks.sh list

# Disable expensive checks during development
./scripts/manage-precommit-hooks.sh disable shellcheck

# Re-enable later
./scripts/manage-precommit-hooks.sh enable shellcheck

# Show hook configuration
./scripts/manage-precommit-hooks.sh show detect-secrets
```

### Manage CI Jobs

```bash
# List all CI workflows and jobs
./scripts/manage-ci-jobs.sh list

# Disable test job (if no tests yet)
./scripts/manage-ci-jobs.sh disable ci.yaml tests

# Enable when ready
./scripts/manage-ci-jobs.sh enable ci.yaml tests

# Show job configuration
./scripts/manage-ci-jobs.sh show security-ci.yml gitleaks
```

See `template/MANAGEMENT_SCRIPTS.md` for complete documentation.

---

## 📂 What's Included

### Cursor Rules (Modern .mdc Format)

```text
.cursor/rules/
├── 001_workspace.mdc            # Repository context
├── 002_design_principles.mdc    # Core design principles
├── 003_bash_standards.mdc       # Shell script standards
├── 004_python_standards.mdc     # Python coding standards
├── 005_yaml_json_standards.mdc  # Data format standards
├── 006_security.mdc             # Security requirements (HIGHEST PRIORITY)
├── 007_precommit.mdc            # Pre-commit workflow
└── 008_documentation.mdc        # Documentation requirements
```

**Features:**

- ✅ Scoped rules (apply only to relevant files)

- ✅ Prioritized (security rules override others)

- ✅ Micro-examples (show correct vs incorrect)

- ✅ Imperative instructions (clear, actionable)

### Claude Desktop Instructions

- **`CLAUDE.md`** - Comprehensive guardrails for Claude

- **`.claudeprompt`** - Single-line for Claude Projects

### GitHub Copilot

- **`.github/copilot-instructions.md`** - Copilot-specific format

### Aider

- **`.aider/.aider.conf.yml`** - Aider configuration

### Continue.dev

- **`.continue/config.yaml`** - Continue agent configuration

- Includes rules (references CONTEXT.md, CONTRIBUTING.md)

- Custom prompts for code review, testing, commit messages

- Context providers for code, diffs, files, terminal

### Windsurf

- **`.windsurfignore`** - Context exclusion patterns (like `.gitignore` for AI)

- **`.vscode/settings.json`** - Editor settings compatible with Windsurf

### Universal

- **`CONTRIBUTING.md`** - For humans and AI contributors

- **`CONTEXT.md`** - Canonical standards document (source of truth)

- **`.vscode/settings.json`** - Python, YAML, JSON, Markdown formatters

---

## 🛡️ Supported AI Tools

| Tool | Config Location | Status |
|------|----------------|--------|
| **Cursor** | `.cursor/rules/*.mdc` | ✅ Fully supported |
| **Claude Desktop** | `CLAUDE.md` | ✅ Fully supported |
| **Claude Projects** | `.claudeprompt` | ✅ Fully supported |
| **GitHub Copilot** | `.github/copilot-instructions.md` | ✅ Fully supported |
| **Aider** | `.aider/.aider.conf.yml` | ✅ Fully supported |
| **Continue.dev** | `.continue/config.yaml` | ✅ Fully supported |
| **Windsurf** | `.windsurfignore` + VS Code settings | ✅ Fully supported |
| **Cody (Sourcegraph)** | Server-side config | ⚠️ Enterprise only |
| **Tabnine** | UI-based config | ⚠️ No file config |
| **Amazon Q** | Server-side config | ⚠️ Pro tier only |

---

## 🔒 Key Standards Enforced

### Security (HIGHEST PRIORITY)

**NEVER commit secrets:**

- ❌ API keys, tokens, passwords

- ❌ Private keys (SSH, TLS)

- ❌ Cloud credentials (AWS, GCP, Azure)

- ✅ Use `.env` files (gitignored)

- ✅ Provide `.env.example` (safe to commit)

### Code Quality

**Bash:**

```bash
#!/usr/bin/env bash
set -euo pipefail
# Quote all variables
rm -rf "${USER_DIR}/temp"
```

**Python:**

```python
def calculate(value: int) -> float:
    """Type hints required for public functions."""
    return float(value) * 1.5
```

**YAML:**

```yaml
# Use .yaml extension, 2-space indent
log_level: "info"
retry_count: 3
```

**JSON:**

```json
{
  "enabled": true,
  "timeout": 30
}
```

### Pre-commit Enforcement

```bash
# All commits must pass quality checks
./scripts/run-precommit.sh
```

**Checks include:**

- Formatting (auto-fixes many issues)

- Linting (code quality)

- Security (secret detection)

- File integrity (symlinks, permissions)

---

## 📖 Documentation

### For AI Assistants

1. **Cursor**: Automatically loads `.cursor/rules/*.mdc`
2. **Claude**: Read `CLAUDE.md` for instructions
3. **Copilot**: Uses `.github/copilot-instructions.md`
4. **Aider**: Configured via `.aider/.aider.conf.yml`
5. **Continue.dev**: Loads `.continue/config.yaml` (references CONTEXT.md)
6. **Windsurf**: Uses `.windsurfignore` and VS Code settings

### For Humans

1. **Quick reference**: See `.cursor/rules/*.mdc` for examples
2. **Detailed standards**: Read `CONTEXT.md`
3. **Contributing**: Read `CONTRIBUTING.md`
4. **Setup guide**: Follow Quick Start above

---

## 🎨 Design Philosophy

### Single Source of Truth

**`CONTEXT.md`** is the canonical standards document. All tool-specific configs
are derived from it. Changes should be made to `CONTEXT.md` first, then
propagated to tool-specific files.

### Tool-Specific Optimization

Each AI tool gets an **optimized configuration**:

- **Cursor**: Scoped `.mdc` files with priority system

- **Claude**: Conversational markdown with checklists

- **Copilot**: Concise, example-heavy format

- **Aider**: YAML config with auto-read files

- **Continue.dev**: YAML config with rules, prompts, and custom commands

- **Windsurf**: Ignore patterns and VS Code integration

### Defense in Depth

Security is enforced at multiple layers:
1. **AI instructions**: "Never commit secrets"
2. **Pre-commit hooks**: Local secret detection
3. **Commit-msg validation**: Check commit messages
4. **CI scanning**: Gitleaks scans full git history

---

## 🔄 Maintenance

### Updating Standards

1. Edit `CONTEXT.md` (canonical source)
2. Update tool-specific files to match
3. Test with each AI tool
4. Commit all changes together

### Adding New Tools

1. Create tool-specific config file
2. Derive content from `CONTEXT.md`
3. Optimize for tool's format
4. Update this README
5. Test thoroughly

---

## 📊 Benefits

### For AI Assistants

- ✅ Native discovery (tools find config automatically)

- ✅ Optimized format (best for each tool's engine)

- ✅ Scoped rules (apply only where relevant)

- ✅ Clear priorities (security overrides everything)

### For Developers

- ✅ Consistency across all AI tools

- ✅ Enforced security (hard to commit secrets)

- ✅ Better code quality from AI suggestions

- ✅ Faster onboarding (AI follows project standards)

### For Projects

- ✅ Maintainable AI-generated code

- ✅ Reduced security incidents

- ✅ Consistent style across contributors

- ✅ Self-documenting standards

---

## 🤝 Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for:

- Setup instructions

- Coding standards

- Development workflow

- Quality checklist

**Note:** Both humans AND AI assistants should read `CONTRIBUTING.md`.

---

## 📄 License

Apache License 2.0 - See [LICENSE](LICENSE) for details.

---

## 🔗 Related Projects

- **GitHub AI Engineering Framework** - Full template with CI/CD, pre-commit, etc.

- Your project here? Open a PR!

---

## 💡 Examples

### Example: Bash Script with Standards

```bash
#!/usr/bin/env bash
set -euo pipefail

# Validate input
if [[ -z "${1:-}" ]]; then
  echo "Error: Missing required argument" >&2
  exit 2
fi

# Quote variables
FILENAME="$1"

# Check file exists
if [[ ! -f "${FILENAME}" ]]; then
  echo "Error: File not found: ${FILENAME}" >&2
  exit 1
fi

# Process file
echo "Processing: ${FILENAME}"
```

### Example: Python with Type Hints

```python
from typing import List

def calculate_average(numbers: List[float]) -> float:
    """Calculate the average of a list of numbers.

    Args:
        numbers: List of numbers to average

    Returns:
        Average value

    Raises:
        ValueError: If list is empty
    """
    if not numbers:
        raise ValueError("Cannot calculate average of empty list")
    return sum(numbers) / len(numbers)
```

### Example: Proper Secret Handling

```python
import os

# ✅ CORRECT: Load from environment
api_key = os.environ.get("OPENAI_API_KEY")
if not api_key:
    raise ValueError("OPENAI_API_KEY environment variable required")

# Provide .env.example (safe to commit):
# OPENAI_API_KEY=your_api_key_here
```

---

## 🎯 Quick Reference

| Need | Command/File |
|------|-------------|
| Setup AI for Cursor | Copy `.cursor/rules/` to your project |
| Setup AI for Claude | Copy `CLAUDE.md` to your project |
| See standards | Read `CONTEXT.md` |
| Contribute | Read `CONTRIBUTING.md` |
| Report issues | Open GitHub issue |

---

**Made with ❤️ for AI-assisted software engineering**
