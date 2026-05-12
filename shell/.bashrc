# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH:/var/home/esme/go/bin:"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

#Esme's Aliases
if command lsd &>/dev/null; then
  alias ls='lsd'
fi

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc

source /var/home/esme/.config/broot/launcher/bash/br
#[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
[ -f $HOMEBREW_PREFIX/etc/profile.d/bash-preexec.sh ] && . $HOMEBREW_PREFIX/etc/profile.d/bash-preexec.sh
if command -v atuin &>/dev/null; then
  eval "$(atuin init bash)"
fi

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Load Angular CLI autocompletion.
source <(ng completion script)

. "$HOME/.local/share/../bin/env"
