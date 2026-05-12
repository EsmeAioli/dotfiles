#!/usr/bin/env bash
# claude-desktop-setup.sh — post-init setup for the claude-desktop distrobox container
# Run by bootstrap.sh after distrobox assemble creates the container

set -euo pipefail

info() { echo -e "\033[1;34m[INFO]\033[0m $*"; }
warn() { echo -e "\033[1;33m[WARN]\033[0m $*"; }
error() {
  echo -e "\033[1;31m[ERROR]\033[0m $*"
  exit 1
}

### CHECK: xhost is available on the host
if ! command -v xhost &>/dev/null; then
  warn "xhost not found — skipping autostart setup. Install xorg-x11-server-utils if needed."
  exit 0
fi

### CHECK: we're not inside a container ourselves
if [[ -f /run/.containerenv ]] || [[ -n "${CONTAINER_ID:-}" ]]; then
  warn "Running inside a container — skipping xhost autostart setup. Run this from the host."
  exit 0
fi

### CREATE: xhost autostart entry
AUTOSTART_DIR="${HOME}/.config/autostart"
AUTOSTART_FILE="${AUTOSTART_DIR}/xhost-toolbox.desktop"

mkdir -p "$AUTOSTART_DIR"

if [[ -f "$AUTOSTART_FILE" ]]; then
  info "Autostart entry already exists at $AUTOSTART_FILE — skipping."
  exit 0
fi

info "Creating xhost autostart entry for user: ${USER}"

cat >"$AUTOSTART_FILE" <<EOF
[Desktop Entry]
Type=Application
Name=xhost toolbox access
Comment=WARNING: grants X server access to local user ${USER}. Has multi-user implications — review before using on shared machines.
Exec=xhost +SI:localuser:${USER}
NoDisplay=true
X-GNOME-Autostart-enabled=true
EOF

info "Autostart entry created at $AUTOSTART_FILE"
info "Will take effect on next login. To apply immediately: xhost +SI:localuser:${USER}"
