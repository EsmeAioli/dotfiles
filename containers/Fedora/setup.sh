# setup.sh
#!/usr/bin/env bash
set -e

# Esme’s container post-creation setup
echo "Setting up dotfiles in container..."
git clone https://github.com/esmeaioli/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./bootstrap.sh

