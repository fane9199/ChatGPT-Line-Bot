#!/bin/bash
# SessionStart hook for Claude Code cloud sessions: installs Python deps into .venv
set -euo pipefail

# Only run in Claude Code cloud sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
cd "$PROJECT_DIR"

# Use a virtualenv: the system (Debian-patched) setuptools fails to build
# opencc-python-reimplemented's legacy setup.py
if [ ! -x .venv/bin/python ]; then
  python3 -m venv .venv
fi

.venv/bin/pip install --quiet --disable-pip-version-check --upgrade pip setuptools wheel
.venv/bin/pip install --quiet --disable-pip-version-check -r requirements.txt

# Make the venv the default python/pip for the rest of the session
if [ -n "${CLAUDE_ENV_FILE:-}" ]; then
  echo "export VIRTUAL_ENV=\"$PROJECT_DIR/.venv\"" >> "$CLAUDE_ENV_FILE"
  echo "export PATH=\"$PROJECT_DIR/.venv/bin:\$PATH\"" >> "$CLAUDE_ENV_FILE"
fi
