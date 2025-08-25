#!/usr/bin/env bash
# desktop/apps.sh — Install Flatpak and RPM packages 
#TODO: or  Install user-facing applications (Flatpak & RPM)


set -euo pipefail
info() { echo -e "\033[1;34m[Desktop/apps.sh]\033[0m $*"; }


# Load overrides if available
if [ -f .env ]; then
source .env
fi


# Default app lists
DEFAULT_FLATPAK_APPS="\
com.spotify.Client \
dev.k8slens.OpenLens \
com.axosoft.GitKraken \
org.gnome.Boxes \
org.telegram.desktop \
com.slack.Slack \
com.discordapp.Discord \
"

# DEFAULT_RPM_APPS="\
# code \
# gitkraken \
# docker-desktop \
# podman-desktop \
# thunderbird \
# openlens"

DEFAULT_RPM_APPS=""

FLATPAK_APPS="${FLATPAK_APPS:-$DEFAULT_FLATPAK_APPS}"
RPM_APPS="${RPM_APPS:-$DEFAULT_RPM_APPS}"


if [ -n "$FLATPAK_APPS" ]; then
info "Installing Flatpak apps..."
flatpak install -y --noninteractive flathub $FLATPAK_APPS
else
info "No Flatpak apps listed, skipping."
fi


if [ -n "$RPM_APPS" ]; then
info "Installing RPM apps (via dnf)..."
sudo dnf install -y $RPM_APPS
else
info "No RPM apps listed, skipping."
fi


info "Application setup complete ✅"