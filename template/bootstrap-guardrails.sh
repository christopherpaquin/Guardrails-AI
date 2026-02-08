#!/usr/bin/env bash
###############################################################################
# bootstrap-guardrails.sh
#
# Copies AI Guardrails infrastructure from template/ to project root.
#
# Usage:
#   ./template/bootstrap-guardrails.sh
#
# What it does:
#   - Copies pre-commit configuration and scripts
#   - Copies CI/CD workflows
#   - Creates necessary directories
#   - Sets up pre-commit hooks
###############################################################################

set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get repository root
if git rev-parse --show-toplevel &> /dev/null; then
  REPO_ROOT="$(git rev-parse --show-toplevel)"
else
  REPO_ROOT="$(pwd)"
fi

TEMPLATE_DIR="${REPO_ROOT}/template"

# Check if template directory exists
if [[ ! -d "${TEMPLATE_DIR}" ]]; then
  echo -e "${RED}Error: template/ directory not found${NC}"
  echo "This script should be run from a repository that contains the AI Guardrails template."
  exit 1
fi

echo "================================================================================"
echo "AI Guardrails Bootstrap"
echo "================================================================================"
echo ""
echo "This script will copy pre-commit infrastructure from template/ to your project."
echo ""
echo -e "${YELLOW}The following will be copied:${NC}"
echo "  - Pre-commit configuration (.pre-commit-config.yaml)"
echo "  - PyMarkdown configuration (.pymarkdown.json)"
echo "  - Security scripts (scripts/detect-secrets.sh, scripts/check-commit-message.sh)"
echo "  - Pre-commit wrapper (scripts/run-precommit.sh)"
echo "  - CI/CD workflows (.github/workflows/ci.yaml, .github/workflows/security-ci.yml)"
echo "  - Development dependencies (requirements-dev.txt)"
echo ""
read -p "Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Aborted."
  exit 1
fi

# Create directories
echo -e "${GREEN}Creating directories...${NC}"
mkdir -p "${REPO_ROOT}/scripts"
mkdir -p "${REPO_ROOT}/.github/workflows"
mkdir -p "${REPO_ROOT}/artifacts"

# Copy files
echo -e "${GREEN}Copying pre-commit configuration...${NC}"
cp "${TEMPLATE_DIR}/.pre-commit-config.yaml" "${REPO_ROOT}/"
cp "${TEMPLATE_DIR}/.pymarkdown.json" "${REPO_ROOT}/"

echo -e "${GREEN}Copying scripts...${NC}"
cp "${TEMPLATE_DIR}/scripts/detect-secrets.sh" "${REPO_ROOT}/scripts/"
cp "${TEMPLATE_DIR}/scripts/check-commit-message.sh" "${REPO_ROOT}/scripts/"
cp "${TEMPLATE_DIR}/scripts/run-precommit.sh" "${REPO_ROOT}/scripts/"
chmod +x "${REPO_ROOT}/scripts/"*.sh

echo -e "${GREEN}Copying CI/CD workflows...${NC}"
cp "${TEMPLATE_DIR}/.github/workflows/ci.yaml" "${REPO_ROOT}/.github/workflows/"
cp "${TEMPLATE_DIR}/.github/workflows/security-ci.yml" "${REPO_ROOT}/.github/workflows/"

echo -e "${GREEN}Copying requirements...${NC}"
if [[ ! -f "${REPO_ROOT}/requirements-dev.txt" ]]; then
  cp "${TEMPLATE_DIR}/requirements-dev.txt" "${REPO_ROOT}/"
else
  echo -e "${YELLOW}  requirements-dev.txt already exists, skipping${NC}"
fi

# Update .gitignore if needed
echo -e "${GREEN}Updating .gitignore...${NC}"
if [[ -f "${REPO_ROOT}/.gitignore" ]]; then
  if ! grep -q "^artifacts/" "${REPO_ROOT}/.gitignore"; then
    echo -e "\n# Pre-commit artifacts and logs\nartifacts/\n.pre-commit-cache/" >> "${REPO_ROOT}/.gitignore"
    echo -e "${GREEN}  Added artifacts/ and .pre-commit-cache/ to .gitignore${NC}"
  else
    echo -e "${YELLOW}  .gitignore already contains artifacts/, skipping${NC}"
  fi
else
  # Copy comprehensive .gitignore template if available
  if [[ -f "${TEMPLATE_DIR}/.gitignore.template" ]]; then
    cp "${TEMPLATE_DIR}/.gitignore.template" "${REPO_ROOT}/.gitignore"
    echo -e "${GREEN}  Copied comprehensive .gitignore from template${NC}"
  else
    # Fallback to basic .gitignore
    cat > "${REPO_ROOT}/.gitignore" << EOF
# Pre-commit artifacts and logs
artifacts/
.pre-commit-cache/

# Python
__pycache__/
*.py[cod]
*.pyc
.pytest_cache/
.mypy_cache/
.ruff_cache/
*.egg-info/
dist/
build/

# Logs
*.log

# OS
.DS_Store
Thumbs.db
EOF
    echo -e "${GREEN}  Created basic .gitignore${NC}"
  fi
fi

# Install pre-commit hooks
echo -e "${GREEN}Installing pre-commit hooks...${NC}"
if command -v pre-commit &> /dev/null; then
  pre-commit install
  pre-commit install --hook-type commit-msg
  echo -e "${GREEN}  Pre-commit hooks installed${NC}"
else
  echo -e "${YELLOW}  Warning: pre-commit not found. Install with: pip install pre-commit${NC}"
  echo -e "${YELLOW}  Then run: pre-commit install && pre-commit install --hook-type commit-msg${NC}"
fi

echo ""
echo "================================================================================"
echo -e "${GREEN}✅ Bootstrap complete!${NC}"
echo "================================================================================"
echo ""
echo "Next steps:"
echo "  1. Install pre-commit (if not already installed):"
echo "     pip install pre-commit"
echo ""
echo "  2. Install development dependencies:"
echo "     pip install -r requirements-dev.txt"
echo ""
echo "  3. Run pre-commit on all files:"
echo "     pre-commit run --all-files"
echo ""
echo "  4. Commit the changes:"
echo "     git add -A"
echo "     git commit -m \"Add AI Guardrails pre-commit infrastructure\""
echo ""
echo "For more information, see:"
echo "  - ${TEMPLATE_DIR}/PRE_COMMIT_SETUP_SUMMARY.md"
echo "  - CONTRIBUTING.md"
echo ""
