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
setopt inc_append_history
HISTSIZE=1200
SAVEHIST=1100

# arrow keys to search history with prefix
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

setopt auto_menu
setopt auto_list

setopt auto_cd
setopt extended_glob

setopt interactive_comments

# aliases
source "$ZDOTDIR/aliases.zsh"

