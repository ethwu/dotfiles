# .zprofile
# ---------
#
# Sets up global state. Sourced only on login shells (i.e., whenever a new
# terminal window is opened, but not when `zsh` is invoked on the command line).

emulate sh
. ~/.profile
emulate zsh

export HISTFILE="$XDG_STATE_HOME/zsh/history"
autoload -Uz compinit
mkdir -p "$XDG_CACHE_HOME/zsh"
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
export SHELL_SESSION_DIR="$XDG_STATE_HOME/zsh/sessions"
export SHELL_SESSION_FILE="$SHELL_SESSION_DIR/$TERM_SESSION_ID"

source "$ZDOTDIR/local/profile.zsh"
