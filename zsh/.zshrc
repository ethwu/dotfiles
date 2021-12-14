# .zshrc
# ------
#
# Configuration for interactive shells. Sourced every time an interactive shell
# is opened.

# term colors
export CLICOLOR=1
autoload -U colors && colors

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

# change partial line output marker
export PROMPT_EOL_MARK="%F{white}%B%S◊%s%b%f"

# fix keybinds
source "$ZDOTDIR/inputrc.zsh"

# zsh options
setopt always_to_end
setopt auto_name_dirs
setopt auto_pushd

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

export HISTFILE="$XDG_STATE_HOME/zsh/history"
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
mkdir -p "$XDG_CACHE_HOME/zsh"
export SHELL_SESSION_DIR="$XDG_STATE_HOME/zsh/sessions"
mkdir -p "$SHELL_SESSION_DIR"
export SHELL_SESSION_FILE="$SHELL_SESSION_DIR/$TERM_SESSION_ID"

# arrow keys to search history with prefix
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

setopt auto_menu
setopt auto_list

# setopt auto_cd
setopt extended_glob

setopt interactive_comments

if [[ -f "$ZDOTDIR/local/plugins.zsh" ]] ; then
    source "$ZDOTDIR/local/plugins.zsh"
fi
export FPATH="$ZDOTDIR/completions:$FPATH"

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# aliases
source "$ZDOTDIR/aliases.zsh"
if [[ -f "$ZDOTDIR/local/local.zsh" ]] ; then
    # local rc
    source "$ZDOTDIR/local/local.zsh"
fi

if [[ "$p10k_available" ]] ; then
    # To customize prompt, run `p10k configure` or edit $ZDOTDIR/.p10k.zsh.
    [[ ! -f "$ZDOTDIR/.p10k.zsh" ]] || source "$ZDOTDIR/.p10k.zsh"

    # local dollar="$POWERLEVEL9K_PROMPT_CHAR_OK_VIINS_CONTENT_EXPANSION"
    local dollar=">"
    export PROMPT2="%F{blue}┃ %F{red}%h %(?.%F{blue}.)$dollar %f"
    export PROMPT3="%F[blue}┃ %(?.%F{blue}.%F{red})#? %f"
    export PROMPT4="%F{blue}┃ %(?.%F{blue}.%F{red})+%N:%i$dollar %f"
    unset dollar
fi

unset p10k_available

