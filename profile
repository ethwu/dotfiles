# .profile
# ---------
#
# Sets up global state. Sourced only on login shells (i.e., whenever a new
# terminal window is openoed. Link this file to ~/.profile.
# Bash ignores this file if ~/.bash_profile or ~/.bash_login exist.

# Set up the XDG Base Directories.
export XDG_BIN_HOME="${XDG_BIN_HOME:=$HOME/.local/bin}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:=$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:=$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:=$HOME/.local/state}"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:=/usr/local/share:/usr/share}"
export XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:=/etc/xdg}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:=$HOME/.local/run/user/$UID}"
export LOCAL="$HOME/.local"
export PATH="$LOCAL/bin:$PATH"

# Path extensions and config flags.

# bat
export BAT_THEME='base16-catalina'

# Java: jenv
export JENV_ROOT="$XDG_DATA_HOME/jenv"

# ls
export LS_COLORS="di=1;34:ln=0;36:pi=0;33:bd=1;33:cd=1;33:so=1;31:ex=1;32:*README=1;4;33:*README.txt=1;4;33:*README.md=1;4;33:*readme.txt=1;4;33:*readme.md=1;4;33:*.ninja=1;4;33:*Makefile=1;4;33:*Cargo.toml=1;4;33:*SConstruct=1;4;33:*CMakeLists.txt=1;4;33:*build.gradle=1;4;33:*pom.xml=1;4;33:*Rakefile=1;4;33:*package.json=1;4;33:*Gruntfile.js=1;4;33:*Gruntfile.coffee=1;4;33:*BUILD=1;4;33:*BUILD.bazel=1;4;33:*WORKSPACE=1;4;33:*build.xml=1;4;33:*Podfile=1;4;33:*webpack.config.js=1;4;33:*meson.build=1;4;33:*composer.json=1;4;33:*RoboFile.php=1;4;33:*PKGBUILD=1;4;33:*Justfile=1;4;33:*Procfile=1;4;33:*Dockerfile=1;4;33:*Containerfile=1;4;33:*Vagrantfile=1;4;33:*Brewfile=1;4;33:*Gemfile=1;4;33:*Pipfile=1;4;33:*build.sbt=1;4;33:*mix.exs=1;4;33:*bsconfig.json=1;4;33:*tsconfig.json=1;4;33:*.zip=0;31:*.tar=0;31:*.Z=0;31:*.z=0;31:*.gz=0;31:*.bz2=0;31:*.a=0;31:*.ar=0;31:*.7z=0;31:*.iso=0;31:*.dmg=0;31:*.tc=0;31:*.rar=0;31:*.par=0;31:*.tgz=0;31:*.xz=0;31:*.txz=0;31:*.lz=0;31:*.tlz=0;31:*.lzma=0;31:*.deb=0;31:*.rpm=0;31:*.zst=0;31:*.lz4=0;31"

# Node.js
export NODE_REPL_HISTORY="$XDG_DATA_HOME/nodejs/node_repl_history"
# NPM
export NPM_CONFIG_PREFIX="$HOME"/.local
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# Perl
export PERL5LIB="$LOCAL/lib/perl5"
export PERL_LOCAL_LIB_ROOT="$LOCAL"
export PERL_MB_OPT="--install_base \"$LOCAL\""
export PERL_MM_OPT="INSTALL_BASE=\"$LOCAL\""

# Python
# export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/startup.py"
export PIPX_HOME="$XDG_DATA_HOME/pipx"
# Poetry
export POETRY_HOME="$XDG_DATA_HOME/poetry"
export PATH="$XDG_DATA_HOME/poetry/bin:$PATH"
# Pylint
export PYLINT_HOME="$XDG_CONFIG_HOME/pylint"
# ipython and jupyter
export IPYTHONDIR="$XDG_DATA_HOME/jupyter"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"

# Racket
export PLTUSERHOME="$XDG_DATA_HOME/racket"

# Ruby: RubyGems
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export PATH="$GEM_HOME/bin:$PATH"

# Rust: Cargo and Rustup
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export PATH="$CARGO_HOME/bin:$PATH"
# blindspot
export BSPM_CONFIG="$XDG_CONFIG_HOME/blindspot/bspm.yaml"
export BSPM_BIN_DIR="$XDG_BIN_HOME"
export BPSM_DATA_DIR="$XDG_DATA_HOME/blindspot"

# SQLite
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite/history"

# Vim
export VIMINIT='source $XDG_CONFIG_HOME/vim/vimrc'

# wget
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'

# Wine
export WINEPREFIX="$XDG_DATA_HOME/wine"

if [ -n "$BASH_VERSION" ] ; then
    [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
    [ -f "$XDG_CONFIG_HOME/bash/bashrc" ] && . "$XDG_CONFIG_HOME/bash/bashrc"
fi

# Add local binaries to PATH.
add_local_bin_to_path() {
    export PATH="$LOCAL/bin:$PATH"
    for i in "$LOCAL/bin"/* ; do
        if [ -d "$i" ] ; then
            export PATH="$i:$PATH"
        fi
    done
    unset -f add_local_bin_to_path
}

