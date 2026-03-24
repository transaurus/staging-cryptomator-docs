#!/usr/bin/env bash
set -euo pipefail

# Rebuild script for cryptomator/docs
# Runs on existing source tree (no clone). Installs deps, runs pre-build steps, builds.

# --- Node version ---
# cryptomator/docs requires Node >=20.0
NODE_MAJOR=$(node --version | sed 's/v//' | cut -d. -f1)
if [ "$NODE_MAJOR" -lt 20 ]; then
    echo "[ERROR] Node $NODE_MAJOR detected, but cryptomator/docs requires Node >=20."
    exit 1
fi
echo "[INFO] Using $(node --version)"

# --- Install dependencies ---
npm ci

# --- Build ---
npm run build

echo "[DONE] Build complete."
