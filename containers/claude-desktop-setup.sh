#!/usr/bin/env bash
# claude-desktop-setup.sh — post-init setup for the claude-desktop distrobox container
# Run by bootstrap.sh after distrobox assemble creates the container

set -euo pipefail

CONTAINER_NAME="claude-desktop"

info() { echo -e "\033[1;34m[INFO]\033[0m $*"; }
warn() { echo -e "\033[1;33m[WARN]\033[0m $*"; }
error() {
  echo -e "\033[1;31m[ERROR]\033[0m $*"
  exit 1
}

### CHECK: we're not inside a container ourselves
if [[ -f /run/.containerenv ]] || [[ -n "${CONTAINER_ID:-}" ]]; then
  warn "Running inside a container — this script must run from the host."
  exit 0
fi

### SETUP: xhost autostart entry
setup_xhost() {
  if ! command -v xhost &>/dev/null; then
    warn "xhost not found — skipping autostart setup. Install xorg-x11-server-utils if needed."
    return 0
  fi

  local autostart_dir="${HOME}/.config/autostart"
  local autostart_file="${autostart_dir}/xhost-toolbox.desktop"

  mkdir -p "$autostart_dir"

  if [[ -f "$autostart_file" ]]; then
    info "Autostart entry already exists at $autostart_file — skipping."
    return 0
  fi

  info "Creating xhost autostart entry for user: ${USER}"

  cat >"$autostart_file" <<EOF
[Desktop Entry]
Type=Application
Name=xhost toolbox access
Comment=WARNING: grants X server access to local user ${USER}. Has multi-user implications — review before using on shared machines.
Exec=xhost +SI:localuser:${USER}
NoDisplay=true
X-GNOME-Autostart-enabled=true
EOF

  info "Autostart entry created at $autostart_file"
  info "Will take effect on next login. To apply immediately: xhost +SI:localuser:${USER}"
}

### SETUP: xdg-open host passthrough
# The app runs with cwd /usr/lib/claude-desktop-unofficial. host-spawn reuses
# the caller's cwd on the host, where that path doesn't exist, so xdg-open
# fails silently. This wrapper cd's to $HOME before handing off to the host.
setup_xdg_open() {
  local wrapper_dir="${HOME}/.config/distrobox"
  local wrapper_file="${wrapper_dir}/xdg-open-wrapper"

  mkdir -p "$wrapper_dir"

  # Quoted 'EOF' so $HOME and $@ are written literally, not expanded now
  cat >"$wrapper_file" <<'EOF'
#!/bin/sh
cd "$HOME"
exec /usr/bin/distrobox-host-exec xdg-open "$@"
EOF
  chmod +x "$wrapper_file"
  info "Wrapper saved to $wrapper_file"

  if ! podman container exists "$CONTAINER_NAME"; then
    warn "Container '$CONTAINER_NAME' not found — wrapper saved but not installed."
    return 0
  fi

  distrobox enter "$CONTAINER_NAME" -- \
    sudo install -m 755 "$wrapper_file" /usr/local/bin/xdg-open
  info "Installed xdg-open passthrough into '$CONTAINER_NAME'"
}

setup_xhost
setup_xdg_open