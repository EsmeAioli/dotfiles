#!/usr/bin/env bash
# desktop/locale.sh — Set system locale, input settings, and timezone


set -euo pipefail
info() { echo -e "\033[1;34m[locale]\033[0m $*"; }


info "Setting system locale to en_GB.UTF-8..."
sudo localectl set-locale LANG=en_GB.UTF-8


info "Setting virtual console keymap to us-intl..." #TODO: somehow it said ml-us-intl which appparently means mayalanm? not multilayout?
sudo localectl set-keymap us-intl


info "Setting X11 keyboard layout to ml,gb with variants us-intl,..."
sudo localectl set-x11-keymap us,gb '' intl,'' #sudo localectl set-x11-keymap ml,gb '' us-intl,''

# info "Setting system timezone to Europe/London..."
# sudo timedatectl set-timezone Europe/London

info "Setting system timezone to Asia/Singapore..."
sudo timedatectl set-timezone Asia/Singapore

info "Locale, input, and timezone configuration applied ✅"