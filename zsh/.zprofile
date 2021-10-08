# .zprofile
# ---------
#
# Sets up global state. Sourced only on login shells (i.e., whenever a new
# terminal window is opened, but not when `zsh` is invoked on the command line).

# Set up the XDG Base Directories.
export LOCAL_HOME="${LOCAL_HOME:=$HOME/.local}"
export XDG_CONFIG_HOME
export XDG_CACHE_HOME="${XDG_CACHE_HOME:=$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:=$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:=$HOME/.local/state}"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:=/usr/local/share:/usr/share}"
export XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:=/etc/xdg}"

# VIM configuration.

export VIMINIT='source $XDG_CONFIG_HOME/vim/vimrc'

# ZSH configuration.

export HISTFILE="$XDG_STATE_HOME/zsh/history"
autoload -Uz compinit
mkdir -p "$XDG_CACHE_HOME/zsh"
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
export SHELL_SESSION_DIR="$XDG_STATE_HOME/zsh/sessions"
export SHELL_SESSION_FILE="$SHELL_SESSION_DIR/$TERM_SESSION_ID"

# Path extensions and config flags.

# Cargo and Rustup
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/cargo"
# . "$CARGO_HOME/env"

# NPM
export NPM_CONFIG_PREFIX="$LOCAL_HOME"

# Local binaries.
export PATH="$LOCAL_HOME/bin:$PATH"
for i in "$LOCAL_HOME/bin"/* ; do
    if [[ -d "$i" ]] ; then
        export PATH="$i:$PATH"
    fi
done

source "$ZDOTDIR/local/profile.zsh"

