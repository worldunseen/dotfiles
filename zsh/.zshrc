#!/bin/zsh

# zsh settings
fpath+=$HOME/.zsh/pure
autoload -U compinit promptinit
compinit
zstyle ':completion::complete:*' use-cache 1
promptinit; prompt pure

# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

# history
export HISTSIZE=500
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups

setopt extendedglob # regex
# export PS1="%2d " # prompt

if [ -n "$RANGER_LEVEL" ]; then export PS1="(ranger) $PS1"; fi

# Vim mode
bindkey -v
bindkey '^R' history-incremental-search-backward
export KEYTIMEOUT=1

# Environment variables
export EDITOR=emacs
export QT_AUTO_SCREEN_SCALE_FACTOR=0

# Aliases/Paths
alias vim=nvim
alias kgitdiff='git difftool --no-symlinks --dir-diff'
alias d="kitty +kitten diff"
alias ssh="kitty +kitten ssh"
alias hg='kitty +kitten hyperlinked_grep'
# if [ -n "$TMUX" ]; then alias ranger='ranger -c'; fi  # fix broken image preview

export PATH="$PATH:/home/$USER/bin:"
