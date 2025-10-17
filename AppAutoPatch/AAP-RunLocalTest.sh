#!/usr/bin/env bash
# Purpose: Download and run the latest App Auto‑Patch script for macOS, then run a AAP session immediately
# Notes:
#   - Downloads into the current user's ~/Downloads directory.
#   - Makes the script executable and runs it with common flags.
#   - Runs Now! Useful for testing and demo purposes.

set -euo pipefail  # Exit on error/undefined var; fail pipelines if any command fails.

# -----------------------------
# Configuration (easy to tweak)
# -----------------------------
SCRIPT_NAME="App-Auto-Patch-via-Dialog.zsh"  # Expected filename of the AAP script
DEST_DIR="$HOME/Downloads"                   # Where to place the script
AAP_URL="https://raw.githubusercontent.com/App-Auto-Patch/App-Auto-Patch/main/${SCRIPT_NAME}"

# -----------------------------
# Pre-flight checks
# -----------------------------

# Ensure curl is available (required for download)
if ! command -v curl >/dev/null 2>&1; then
  echo "Error: 'curl' not found. Please install curl and re-run." >&2
  exit 1
fi

# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# -----------------------------
# Download the latest script
# -----------------------------
# -f: fail on server errors
# -sS: silent with errors
# -L : follow redirects (GitHub RAW uses redirects)
# -o : write to the specified file (in Downloads)
curl -fsSL -o "${DEST_DIR}/${SCRIPT_NAME}" "$AAP_URL"

# -----------------------------
# Move into the destination dir
# -----------------------------
cd "$DEST_DIR"

# -----------------------------
# Make the script executable
# -----------------------------
# Use non-sudo chmod; file is in the current user's home and should be owned by them.
chmod a+x "./${SCRIPT_NAME}"

# -----------------------------
# Run App Auto‑Patch
# -----------------------------
# --debug-mode               : verbose logging to aid troubleshooting
# --workflow-install-now     : run the “install now” workflow immediately
# (Use sudo to allow privileged tasks the script may perform.)
sudo "./${SCRIPT_NAME}" --debug-mode --workflow-install-now