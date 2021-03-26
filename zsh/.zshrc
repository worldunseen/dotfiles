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
export EDITOR=nvim
export QT_AUTO_SCREEN_SCALE_FACTOR=0

# Aliases/Paths
alias vim=nvim
alias kgitdiff='git difftool --no-symlinks --dir-diff'
alias d="kitty +kitten diff"
alias ssh="kitty +kitten ssh"
alias docker="podman"
# if [ -n "$TMUX" ]; then alias ranger='ranger -c'; fi  # fix broken image preview

export PATH="$PATH:/home/$USER/bin:/home/$USER/.local/bin:"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/mf/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/mf/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/mf/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/mf/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

