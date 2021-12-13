# .profile
# ---------
#
# Sets up global state. Sourced only on login shells (i.e., whenever a new
# terminal window is openoed. Link this file to ~/.profile.
# Bash ignores this file if ~/.bash_profile or ~/.bash_login exist.

# Set up the XDG Base Directories.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:=$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:=$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:=$HOME/.local/state}"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:=/usr/local/share:/usr/share}"
export XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:=/etc/xdg}"

# VIM configuration.

export VIMINIT='source $XDG_CONFIG_HOME/vim/vimrc'

# Path extensions and config flags.

# Node.js
export NODE_REPL_HISTORY="$XDG_DATA_HOME/nodejs/node_repl_history"
# NPM
export NPM_CONFIG_PREFIX="$HOME"/.local
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# Python
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/startup.py"
export PIPX_HOME="$XDG_DATA_HOME/pipx"
# Poetry
export POETRY_HOME="$XDG_DATA_HOME/poetry"
export PATH="$XDG_DATA_HOME/poetry/bin:$PATH"
# Pylint
export PYLINT_HOME="$XDG_CONFIG_HOME/pylint"

# Racket
export PLTUSERHOME="$XDG_DATA_HOME/racket"

# Rust: Cargo and Rustup
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export PATH="$CARGO_HOME/bin:$PATH"

# wget
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'

if [ -n "$BASH_VERSION" ] ; then
    [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
    [ -f "$XDG_CONFIG_HOME/bash/bashrc" ] && . "$XDG_CONFIG_HOME/bash/bashrc"
fi

# Add local binaries to PATH.
add_local_bin_to_path() {
    export PATH="$HOME/.local/bin:$PATH"
    for i in "$HOME/.local/bin"/* ; do
        if [ -d "$i" ] ; then
            export PATH="$i:$PATH"
        fi
    done
    unset -f add_local_bin_to_path
}

