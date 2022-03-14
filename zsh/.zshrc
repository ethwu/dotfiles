# .zshrc
# ------
#
# Configuration for interactive shells. Sourced every time an interactive shell
# is opened.

# term colors
export CLICOLOR=1
autoload -U colors && colors

# set default value of $ZDOTDIR
if [[ -n "$ZDOTDIR" ]] ; then
    config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
    if [[ -d "$config_dir" ]] ; then
        ZDOTDIR="$config_dir"
    else
        ZDOTDIR="$HOME"
    fi
    unset config_dir
fi

[[ "$EUID" -gt 0 && -f "$ZDOTDIR/local/pre.zsh" ]] && source "$ZDOTDIR/local/pre.zsh"

if [[ -f "$ZDOTDIR/local/prompt.zsh" ]] ; then
    source "$ZDOTDIR/local/prompt.zsh"
else
    # whether p10k is available
    local p10k_available=

    # Enable Powerlevel10k instant prompt. Should stay close to the top of .zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]] ; then
        p10k_available=yes
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi

    # prompt
    if [[ ! "$p10k_available" ]] && [[ "$CATALINA_ENABLED" != 'false' ]] ; then
        source "$ZDOTDIR/prompt.zsh" --host --elapsed --vcs
    fi
fi

# prompt continuation
export PROMPT2="%(?.%F{blue}.%F{red})┆ %F{red}%! %F{yellow}%_%(?.%F{blue}.%F{red})%B>%b%f "
# `select` prompt
export PROMPT3="%F{blue}%B?)%b%f "
# debug prompt
export PROMPT4="%F{green}┆ %N%f:%F{yellow}%i%f "
# change partial line output marker
export PROMPT_EOL_MARK="%F{white}%B%S◊%s%b%f"

# fix keybinds
[[ -f "$ZDOTDIR/inputrc.zsh" ]] && source "$ZDOTDIR/inputrc.zsh"

# zsh options
setopt always_to_end
# use parameters with the abs. path to a dir as the name of that dir
setopt auto_name_dirs
# cd pushes the old directory onto the directory stack
setopt auto_pushd
# cd to a dir when its name is executed as a command
setopt auto_cd
# ignore multiple copies of the same directory when pushing to the dir stack
setopt pushd_ignore_dups
# add trailing slash to dir names resulting from filename generation
setopt mark_dirs

# display PID when suspending processes
setopt longlistjobs
# complete commands from inside word
setopt completeinword

setopt extended_history
setopt hist_expire_dups_first
# append instead of overwrite history file
setopt append_history
# save history after every command
setopt inc_append_history
# no blanks in history
setopt hist_reduce_blanks
# ignore adjacent duplicates when searching
setopt hist_find_no_dups
# confirm bang history
setopt hist_verify
HISTSIZE=1200
SAVEHIST=1100

export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"
[[ "$EUID" -gt 0 ]] && mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
export SHELL_SESSION_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/sessions"
[[ "$EUID" -gt 0 ]] && mkdir -p "$SHELL_SESSION_DIR"
export SHELL_SESSION_FILE="$SHELL_SESSION_DIR/$TERM_SESSION_ID"

# use colors in completion
zstyle  ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Use emacs keybinds despite value of $EDITOR or $VISUAL.
bindkey -e
# Still allow ESC to trigger vi command mode.
bindkey '^[' vi-cmd-mode
# Reduce timeout on prefixes from 0.4s to 0.05s.
export KEYTIMEOUT=5

# arrow keys to search history with prefix
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^[[A' history-beginning-search-backward-end
bindkey '^[[B' history-beginning-search-forward-end

setopt auto_menu
setopt auto_list

# setopt auto_cd
setopt extended_glob
# allow ** to be equal to **/* and *** to be equal to ***/*
setopt glob_star_short

setopt interactive_comments

if [[ "$EUID" -gt 0 ]] ; then
    [[ -f "$ZDOTDIR/local/plugins.zsh" ]] && source "$ZDOTDIR/local/plugins.zsh"
    export FPATH="$ZDOTDIR/autoload:$ZDOTDIR/completions:$FPATH"

    if [[ -d "$ZDOTDIR/autoload/" && "$(ls "$ZDOTDIR/autoload/")" ]] ; then
        # autoload all functions in $ZDOTDIR/autoload/
        autoload -Uz $fpath[1]/*(.:t)
    fi

    autoload -Uz compinit
    compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION"

    # aliases
    [[ -f "$ZDOTDIR/aliases.zsh" ]] && source "$ZDOTDIR/aliases.zsh"
    # local rc
    [[ -f "$ZDOTDIR/local/local.zsh" ]] && source "$ZDOTDIR/local/local.zsh"
fi

unset p10k_available

typeset -U path cdpath fpath manpath

