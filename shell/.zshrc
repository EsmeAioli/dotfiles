

#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

autoload -U compinit
compinit

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH:/var/home/esme/go/bin:"
fi
export PATH

#Esme's Aliases
if command lsd &> /dev/null; then 
  alias ls='lsd'
fi 

#zsh-completions (brew installed)
if type brew &>/dev/null; then
FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

autoload -Uz compinit
compinit
fi

#Esme's Manual zsh plugin repository
source ~/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source ~/.zsh/plugins/kubectl-fzf.sh # https://github.com/codenio/kubectl-fzf 

#TODO: Consider zsh plugin managers like: zinit, zsh-plug or antigen (Something lightweight)


#
#fzf-tab Modifications
#

#Don't know if I notice a difference here 
# zstyle ':fzf-tab:*' fzf-flags --no-sort


# Preview directories and files
zstyle ':fzf-tab:complete:*:*' fzf-preview 'bat --color=always --style=numbers --line-range=:100 $realpath 2>/dev/null || eza -1 --color=always $realpath 2>/dev/null || echo $word'
zstyle ':fzf-tab:complete:go:*' fzf-preview ''
zstyle ':fzf-tab:complete:kubectl:*' fzf-preview ''

# Show what context zsh thinks it's in during completion
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'

#kubectl override 
# zstyle ':fzf-tab:complete:kubectl:*' fzf-preview ''
#zstyle ':fzf-tab:complete:*:kubectl-apply:f' fzf-preview 'bat --color=always --style=numbers --line-range=:100 $realpath 2>/dev/null || eza -1 --color=always $realpath 2>/dev/null || echo $word' #Can I make the file show up for kubectl apply -f


# Group colors for when completions are categorized
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' group-colors $'\033[33m' $'\033[37m' #Do I know what this does?

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD


## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## history
#setopt APPEND_HISTORY
## for sharing history between zsh processes
#setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY

## never ever beep ever
#setopt NO_BEEP

## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0

# autoload -U colors
#colors

source /var/home/esme/.config/broot/launcher/bash/br

. "$HOME/.local/share/../bin/env"

if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi 

if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh)"
fi
