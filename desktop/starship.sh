#!/usr/bin/env bash
# desktop/starship.sh — Install Esme's Starship prompt config
#
# NOTE:
# This script lives in `desktop/` not because it's part of a traditional GUI desktop environment,
# but because this folder contains everything user-facing that defines how "home" feels for Esme.
# It includes visual preferences, UI tweaks, fonts, themes, and shell prompt aesthetics.
#
# If shell setup becomes more complex, shell config may move to `shell/config/` and
# executable scripts into `shell/scripts/` for clarity.

set -euo pipefail
info() { echo -e "\033[1;34m[Desktop/starship.sh]\033[0m $*"; }

# CONFIG
DEFAULT_REPO_URL="https://github.com/EsmeAioli/pastel-powerline-kate.git"
REPO_URL="${STARSHIP_REPO_URL:-$DEFAULT_REPO_URL}"
DEST_DIR="${HOME}/.cache/starship-clone"
CONFIG_PATH="${HOME}/.config/starship.toml"

info "Setting up Starship prompt config from $REPO_URL..."
mkdir -p "${HOME}/.config"

if [[ -d "$DEST_DIR/.git" ]]; then
    info "Updating existing Starship config repo..."
    git -C "$DEST_DIR" pull --quiet
else
    info "Cloning Starship config from remote..."
    git clone --quiet "$REPO_URL" "$DEST_DIR"
fi

if [[ -f "$DEST_DIR/starship.toml" ]]; then
    cp "$DEST_DIR/starship.toml" "$CONFIG_PATH"
    info "Installed starship.toml to ~/.config ✅"
else
    echo "[ERROR] starship.toml not found in repo!" >&2
    exit 1
fi
