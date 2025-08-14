# =========================================
# Esme's .bashrc
# Clean, minimal, aligned with Bluefin defaults
# =========================================

# --- Source global definitions ---
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# --- PATH setup ---
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH:/var/home/esme/go/bin:"
fi
export PATH

# Uncomment to disable systemctl auto-paging:
# export SYSTEMD_PAGER=

# --- Aliases ---
alias ls='lsd'

# --- Modular configs ---
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        [ -f "$rc" ] && . "$rc"
    done
fi
unset rc

# --- Tools & integrations ---
source /var/home/esme/.config/broot/launcher/bash/br
[ -f $HOMEBREW_PREFIX/etc/profile.d/bash-preexec.sh ] && . $HOMEBREW_PREFIX/etc/profile.d/bash-preexec.sh
eval "$(atuin init bash)"