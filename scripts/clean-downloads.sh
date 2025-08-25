#!/usr/bin/env bash

# Esme's Downloads folder cleaner — now systemd compatible & toggleable!
# Optional flags:
#   --enable     Enables and starts the systemd timer
#   --disable    Stops and disables the systemd timer
#   --help       Prints usage info

SERVICE_NAME="clean-downloads"
SYSTEMD_DIR="$HOME/.config/systemd/user"
DOWNLOADS_DIR="$HOME/Downloads"

usage() {
  echo "Usage: $0 [--enable|--disable|--help]"
  exit 1
}

enable_timer() {
  mkdir -p "$SYSTEMD_DIR"
  cp "$(dirname "$0")/${SERVICE_NAME}.service" "$SYSTEMD_DIR/"
  cp "$(dirname "$0")/${SERVICE_NAME}.timer" "$SYSTEMD_DIR/"
  systemctl --user daemon-reexec
  systemctl --user daemon-reload
  systemctl --user enable --now "${SERVICE_NAME}.timer"
  echo "✅ Timer enabled and running."
}

disable_timer() {
  systemctl --user disable --now "${SERVICE_NAME}.timer"
  echo "🛑 Timer disabled and stopped."
}

# Flag handling
case "$1" in
  --enable) enable_timer ;;
  --disable) disable_timer ;;
  --help) usage ;;
  "" )
    echo "🧹 Cleaning up $DOWNLOADS_DIR..."
    if [[ -d "$DOWNLOADS_DIR" ]]; then
      find "$DOWNLOADS_DIR" -mindepth 1 -delete
      echo "✅ Downloads folder wiped clean at $(date)"
    else
      echo "⚠️  Downloads directory not found: $DOWNLOADS_DIR"
    fi
    ;;
  *) usage ;;
esac
