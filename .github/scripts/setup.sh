#!/bin/bash
# Setup script for: https://github.com/cryptomator/docs
# Docusaurus 3.9.2, npm, Node >= 20

set -e

REPO_URL="https://github.com/cryptomator/docs.git"
BRANCH="main"
DOCUSAURUS_PATH="."

echo "Setting up cryptomator/docs for i18n generation..."

# Clean up if exists
if [ -d "source-repo" ]; then
  echo "Cleaning up existing directory..."
  rm -rf "source-repo"
fi

# Clone repository
echo "Cloning repository..."
git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "source-repo"

cd "source-repo"

# Install dependencies with npm
echo "Installing dependencies with npm..."
npm ci

# Generate i18n files
echo "Generating i18n translation files..."
npm run write-translations

# Verify i18n files were created
if [ -d "i18n/en" ]; then
  echo "i18n files successfully generated!"
  echo "Generated files in:"
  ls -la i18n/en/
else
  echo "Failed to generate i18n files"
  exit 1
fi

echo "Setup complete!"
