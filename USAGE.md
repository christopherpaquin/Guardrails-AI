# Usage Guide - AI Guardrails

Complete guide for using AI Guardrails in your projects.

---

## 📋 Table of Contents

- [Installation Methods](#-installation-methods)
- [Per-Tool Setup](#-per-tool-setup)
- [Verifying Setup](#-verifying-setup)
- [Usage Examples](#-usage-examples)
- [Troubleshooting](#-troubleshooting)

---

## 🚀 Installation Methods

### Method 1: Git Submodule (Recommended)

Best for ongoing updates and maintenance:

```bash
# Add as submodule
cd your-project
git submodule add https://github.com/your-org/Guardrails-AI .ai-guardrails

# Initialize submodule
git submodule update --init --recursive

# Create symlinks
ln -s .ai-guardrails/.cursor .cursor
ln -s .ai-guardrails/CLAUDE.md CLAUDE.md
ln -s .ai-guardrails/CONTRIBUTING.md CONTRIBUTING.md

# Commit the submodule
git add .gitmodules .ai-guardrails .cursor CLAUDE.md CONTRIBUTING.md
git commit -m "Add AI guardrails"
```

**Updating:**
```bash
# Pull latest guardrail updates
git submodule update --remote .ai-guardrails
```

### Method 2: Direct Copy

Best for one-time setup or customization:

```bash
# Clone guardrails
git clone https://github.com/your-org/Guardrails-AI /tmp/guardrails

# Copy files to your project
cd your-project
cp -r /tmp/guardrails/.cursor .
cp /tmp/guardrails/CLAUDE.md .
cp /tmp/guardrails/CONTRIBUTING.md .
cp /tmp/guardrails/.claudeprompt .
cp -r /tmp/guardrails/.github/copilot-instructions.md .github/

# Cleanup
rm -rf /tmp/guardrails

# Commit
git add .cursor CLAUDE.md CONTRIBUTING.md .claudeprompt .github
git commit -m "Add AI guardrails"
```

### Method 3: Selective Files

Copy only what you need:

```bash
# For Cursor only
cp -r /path/to/guardrails/.cursor your-project/

# For Claude only
cp /path/to/guardrails/CLAUDE.md your-project/
cp /path/to/guardrails/.claudeprompt your-project/

# For GitHub Copilot only
cp /path/to/guardrails/.github/copilot-instructions.md your-project/.github/
```

---

## 🤖 Per-Tool Setup

### Cursor Setup

1. **Copy rules:**
   ```bash
   cp -r .ai-guardrails/.cursor .
   ```

2. **Verify in Cursor:**
   - Open Cursor IDE
   - Check: Settings → Cursor Settings → Rules
   - Should show 8 rules loaded

3. **Test:**
   - Open a `.sh` file → Rules 003 (bash) should apply
   - Open a `.py` file → Rules 004 (python) should apply
   - Rule 006 (security) applies to all files

### Claude Desktop Setup

1. **Copy instructions:**
   ```bash
   cp .ai-guardrails/CLAUDE.md .
   ```

2. **Reference in conversations:**
   ```
   Please follow the standards in CLAUDE.md when making changes.
   ```

3. **Claude will:**
   - Read CLAUDE.md automatically (if in project root)
   - Follow security guardrails
   - Enforce coding standards

### Claude Projects Setup

1. **Copy prompt file:**
   ```bash
   cp .ai-guardrails/.claudeprompt .
   ```

2. **Claude Projects reads:**
   - `.claudeprompt` automatically
   - Applies to all conversations in that project

### GitHub Copilot Setup

1. **Copy instructions:**
   ```bash
   mkdir -p .github
   cp .ai-guardrails/.github/copilot-instructions.md .github/
   ```

2. **GitHub Copilot reads:**
   - `.github/copilot-instructions.md` automatically
   - Applies to all suggestions

### Aider Setup

1. **Copy configuration:**
   ```bash
   cp -r .ai-guardrails/.aider .
   ```

2. **Aider will:**
   - Read configuration automatically
   - Load CONTEXT.md for context
   - Run pre-commit before commits

---

## ✅ Verifying Setup

### Check Files Are Present

```bash
# For Cursor
ls -la .cursor/rules/

# For Claude
ls -la CLAUDE.md .claudeprompt

# For Copilot
ls -la .github/copilot-instructions.md

# For Aider
ls -la .aider/.aider.conf.yml
```

### Test with Your AI Tool

#### Cursor Test

1. Open Cursor IDE
2. Create a new `.sh` file
3. Type `#!/bin/bash` and wait for suggestions
4. Cursor should suggest adding `set -euo pipefail`

#### Claude Test

1. Open Claude Desktop
2. Reference your project
3. Ask: "Create a bash script to process files"
4. Claude should include `set -euo pipefail`

#### Copilot Test

1. Open VS Code with Copilot
2. Create a new `.py` file
3. Start typing a function
4. Copilot should suggest type hints

---

## 💡 Usage Examples

### Example 1: Starting a New Feature

```bash
# 1. AI assistant reads guardrails automatically
# 2. Ask AI to implement feature
# 3. AI generates code following standards
# 4. Run pre-commit
./scripts/run-precommit.sh

# 5. Commit
git commit -m "Add feature X"
```

### Example 2: Code Review with AI

```
Please review this code for:
1. Security issues (secrets, input validation)
2. Compliance with standards in CLAUDE.md
3. Pre-commit compatibility
```

### Example 3: Refactoring

```
Please refactor this bash script to follow standards:
- Add set -euo pipefail
- Quote all variables
- Add input validation
- Add clear error messages
```

---

## 🔧 Troubleshooting

### Issue: AI not following standards

**Solution:**
1. Verify config files are in correct locations
2. Explicitly reference the files:
   - "Please follow CLAUDE.md"
   - "Follow standards in .cursor/rules/"
3. Quote specific rules from the config files

### Issue: Cursor rules not loading

**Solution:**
1. Check Settings → Cursor Settings → Rules
2. Verify `.cursor/rules/` directory exists
3. Restart Cursor IDE
4. Check file permissions (should be readable)

### Issue: Pre-commit failing

**Solution:**
1. Read error in `artifacts/pre-commit.log`
2. Many hooks auto-fix - run again
3. Fix remaining issues manually
4. Ensure secrets are in `.env`, not code

---

## 🔄 Keeping Guardrails Updated

### If Using Submodule

```bash
# Update to latest guardrails
git submodule update --remote .ai-guardrails

# Review changes
cd .ai-guardrails
git log

# Commit the update
cd ..
git add .ai-guardrails
git commit -m "Update AI guardrails"
```

### If Using Direct Copy

```bash
# Pull latest guardrails
cd /tmp
git clone <guardrails-repo> guardrails
cd guardrails
git pull

# Copy updated files
cp -r .cursor your-project/
cp CLAUDE.md your-project/
# ... etc

# Commit updates
cd your-project
git add .cursor CLAUDE.md
git commit -m "Update AI guardrails"
```

---

## 📊 Integration with Your Project

### Customize for Your Project

You can extend the base guardrails:

**Option A: Add project-specific rules**
```bash
# Create project-specific Cursor rules
cat > .cursor/rules/100_project_specific.mdc << 'EOF'
---
description: Project-specific rules
priority: 60
globs:
  - "src/**"
---

# Project-Specific Standards

- Use our custom logging framework
- Follow our API design patterns
- ...
EOF
```

**Option B: Extend CLAUDE.md**
```markdown
<!-- At end of CLAUDE.md -->

---

## Project-Specific Additions

- Use React for frontend
- PostgreSQL for database
- FastAPI for backend API
```

### Keep Base Guardrails Clean

- Don't modify base guardrail files directly
- Add project-specific rules separately
- Makes updates easier (no merge conflicts)

---

## 🎯 Best Practices

1. **Set up guardrails FIRST** - Before writing code
2. **Reference explicitly** - Tell AI "Follow CLAUDE.md"
3. **Test thoroughly** - Verify AI follows standards
4. **Update documentation** - When you customize
5. **Keep updated** - Pull guardrail updates regularly

---

## 📚 Additional Resources

- [Cursor Rules Documentation](https://learn-cursor.com/)
- [Claude Projects Guide](https://docs.anthropic.com/)
- [GitHub Copilot Docs](https://docs.github.com/copilot)
- [Aider Documentation](https://aider.chat/docs/)

---

**Questions?** Open an issue or check `CONTRIBUTING.md`
