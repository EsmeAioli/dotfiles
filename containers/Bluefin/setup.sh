#!/usr/bin/env bash
set -euo pipefail

log() {
  echo "[bluefin/setup.sh] $*"
}

# Check if Homebrew exists (Bluefin usually includes it)
if ! command -v brew &> /dev/null; then
  log "Homebrew not found. Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  log "Homebrew already installed."
fi

# Setup brew bundle if Brewfile is present
if [[ -f "/dotfiles/brew/Brewfile" ]]; then
  log "Installing packages from Brewfile..."
  brew bundle --file="/dotfiles/brew/Brewfile"
else
  log "No Brewfile found in /dotfiles/brew/. Skipping brew bundle."
fi

# Run bootstrap if available
if [[ -x "/dotfiles/bootstrap.sh" ]]; then
  log "Running dotfiles bootstrap script..."
  /dotfiles/bootstrap.sh
else
  log "No bootstrap.sh found or not executable. Skipping bootstrap."
fi

log "Setup complete."
