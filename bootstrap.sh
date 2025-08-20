#!/usr/bin/env bash
# bootstrap.sh — Esme's dotfiles bootstrap script
# Makes a Bluefin-based Linux box feel like home x

set -euo pipefail

### CONFIG
DOTFILES_DIR="${HOME}/dotfiles"
BREWFILE="${DOTFILES_DIR}/brew/Brewfile"
CONTAINERS_DIR="${DOTFILES_DIR}/containers"
DESKTOP_DIR="${DOTFILES_DIR}/desktop"
SHELL_DIR="${DOTFILES_DIR}/shell"
SCRIPTS_DIR="${DOTFILES_DIR}/scripts"

### HELPERS
info()    { echo -e "\033[1;34m[INFO]\033[0m $*"; }
warn()    { echo -e "\033[1;33m[WARN]\033[0m $*"; }
error()   { echo -e "\033[1;31m[ERROR]\033[0m $*"; exit 1; }

### LOAD .env if present
if [[ -f "${DOTFILES_DIR}/.env" ]]; then
    info "Loading environment variables from .env"
    set -a
    source "${DOTFILES_DIR}/.env"
    set +a
else
    warn ".env file not found. Using defaults. You may want to copy .env.example → .env"
fi

### CHECK: Are we on Bluefin?
if ! grep -q "Bluefin" /etc/os-release 2>/dev/null; then
    warn "This system does not appear to be Bluefin."
    read -p "Continue anyway? [y/N] " confirm
    [[ "$confirm" =~ ^[Yy]$ ]] || error "Aborting. This script is for Bluefin-based systems."
fi

### 1. Install Homebrew (if not installed)
if ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

### 2. Restore Brewfile packages
if [[ -f "$BREWFILE" ]]; then
    info "Restoring packages from Brewfile..."
    brew bundle --file="$BREWFILE"
else
    warn "No Brewfile found at $BREWFILE. Skipping package restore."
fi

### 3. Symlink shell configs
info "Linking shell configuration..."
mkdir -p "${HOME}/.config"
ln -sf "${SHELL_DIR}/.bashrc" "${HOME}/.bashrc"
ln -sf "${SHELL_DIR}/.bash_aliases" "${HOME}/.bash_aliases"
# Add more as needed

### 4. Symlink scripts (optional)
if [[ -d "$SCRIPTS_DIR" ]]; then
    info "Linking helper scripts to ~/bin..."
    mkdir -p "${HOME}/bin"
    for script in "$SCRIPTS_DIR"/*; do
        ln -sf "$script" "${HOME}/bin/$(basename "$script")"
    done
fi

### 5. Desktop environment setup
if [[ -d "$DESKTOP_DIR" ]]; then
    info "Applying desktop customisations..."
    for setup_script in "$DESKTOP_DIR"/*.sh; do
        script_name=$(basename "$setup_script")
        info "Running $script_name..."
        bash "$setup_script"
    done
else
    warn "No desktop setup folder found at $DESKTOP_DIR."
fi

### 6. Setup Distrobox containers
if command -v distrobox &>/dev/null && [[ -d "$CONTAINERS_DIR" ]]; then
    info "Setting up Distrobox containers..."
    for container in "$CONTAINERS_DIR"/*.ini; do
        name=$(basename "$container" .ini)
        info "Creating container: $name"
        distrobox-create --name "$name" --file "$container" || warn "Failed to create container $name"
    done
else
    warn "Distrobox not installed or containers dir missing. Skipping container setup."
fi

info "Bootstrap complete! 🎉"
info "You may want to restart or re-login for shell and desktop settings to fully apply."
