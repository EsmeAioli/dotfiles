#!/usr/bin/env bash
set -euo pipefail
info() { echo -e "\033[1;34m[Desktop/git.sh]\\033[0m $*"; }

info "Ensuring minimal host Git setup..."

git config --global init.defaultBranch main

# Optional: if you're pulling dotfiles or using Git occasionally on the host
if [[ -n "${GIT_NAME:-}" && -n "${GIT_EMAIL:-}" ]]; then
  info "Setting user.name and user.email from .env..."
  git config --global user.name "$GIT_NAME"
  git config --global user.email "$GIT_EMAIL"
else
  info "Skipping Git user config (no GIT_NAME or GIT_EMAIL in .env)"
fi
