
#!/usr/bin/env bash
# desktop/gnome.sh — GNOME UI preferences (themes, favourites, layout)

set -euo pipefail
info() { echo -e "\033[1;34m[Desktop/gnome.sh]\033[0m $*"; }

# Replace this with your current list — run this on a configured machine to get it:
# gsettings get org.gnome.shell favorite-apps

# Load overrides if available
if [ -f .env ]; then
  source .env
fi


DEFAULT_DOCK_ITEMS=(
  'org.gnome.Software.desktop'
  'org.mozilla.Thunderbird.desktop'
  'org.gnome.Nautilus.desktop'
  'com.spotify.Client.desktop'
  'dev.k8slens.OpenLens.desktop'
  'com.axosoft.GitKraken.desktop'
  'org.gnome.Ptyxis.desktop'
  'code.desktop'
  'docker-desktop.desktop'
  'io.podman_desktop.PodmanDesktop.desktop'
  'org.gnome.Boxes.desktop'
  'io.github.dvlv.boxbuddyrs.desktop'
  'org.telegram.desktop.desktop'
  'com.slack.Slack.desktop'
  'com.discordapp.Discord.desktop'
  'org.mozilla.firefox.desktop'
  'org.gnome.Settings.desktop'
)

# Use override if present
if [ -n "${DOCK_ITEMS:-}" ]; then
  IFS=' ' read -r -a favourites <<< "$DOCK_ITEMS"
else
  favourites=("${DEFAULT_DOCK_ITEMS[@]}")
fi

info "Configuring GNOME dock favourites..."
gsettings set org.gnome.shell favorite-apps "[$(printf "'%s', " "${favourites[@]}" | sed 's/, $//')]"

info "GNOME dock configuration complete ✅"


# FAV_STR="[$(IFS=,; echo "'${FAVOURITES[*]}'")"]" #TODO: something is wrong syntactically 


# info "Setting pinned favourites: $FAV_STR"
# gsettings set org.gnome.shell favorite-apps "$FAV_STR"


# info "GNOME preferences applied ✅"


# info "Applying GTK theme and icon settings..."
# gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
# gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
# gsettings set org.gnome.desktop.interface monospace-font-name 'Fira Code 11'
# gsettings set org.gnome.desktop.interface enable-animations false

# info "Setting workspace keybindings..."
# gsettings set org.gnome.desktop.wm.keybindings.switch-to-workspace-left "['<Super><Shift>Left']"
# gsettings set org.gnome.desktop.wm.keybindings.switch-to-workspace-right "['<Super><Shift>Right']"

# info "GNOME desktop tweaks complete."
