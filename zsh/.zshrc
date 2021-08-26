# .zshrc
# ------
#
# Configuration for interactive shells. Sourced every time an interactive shell
# is opened.

# term colors
export CLICOLOR=1
autoload -U colors && colors

# prompt
source "$ZDOTDIR/prompt.zsh" --host --elapsed --vcs

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

# arrow keys to search history with prefix
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

setopt auto_menu
setopt auto_list

setopt auto_cd
setopt extended_glob

setopt interactive_comments

# aliases
source "$ZDOTDIR/aliases.zsh"
# plugins
source "$ZDOTDIR/plugins.zsh"

