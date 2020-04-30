# Randoragon's ZSH config file

# VALUABLE SOURCES
# https://wiki.archlinux.org/index.php/Zsh#Installation
# https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
# https://youtu.be/eLEo4OQ-cuQ

#################################################################
#                          GENERAL                              #
#################################################################

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History and its location
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

autoload -Uz compinit promptinit
compinit
promptinit

# Disable freezing terminal with Ctrl-S
stty stop undef	

# Discard duplicates from $PATH and $path (Zsh ties PATH to path)
typeset -U PATH path
path=("$HOME/.local/bin" "$path[@]")
export PATH

# Enable variable word splitting
# http://zsh.sourceforge.net/FAQ/zshfaq03.html
setopt shwordsplit

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Allow GnuPG to use console for authentication
export GPG_TTY="$(tty)"

# Load jumplist and aliases
[ -f "$HOME/.config/jumprc" ] && . "$HOME/.config/jumprc"
[ -f "$HOME/.config/aliasrc" ] && . "$HOME/.config/aliasrc"

# Load pywal custom theme on tty
source ~/.cache/wal/colors-tty.sh


#################################################################
#                       AUTOCOMPLETION                          #
#################################################################

# Enable autocompletion
autoload -Uz compinit
compinit

# Enable light-up menu
zstyle ':completion:*' menu select
zmodload zsh/complist

# Enable completion for hidden files
_comp_options+=(globdots)

#################################################################
#                           KEYBOARD                            #
#################################################################

# Enable VI mode
bindkey -v

# Open line in vim for editing
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Navigate tab completion with vim keys
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

#################################################################
#                           PLUGINS                             #
#################################################################

# zsh-syntax-highlighting (must be loaded last!)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

