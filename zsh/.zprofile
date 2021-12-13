# .zprofile
# ---------
#
# Sets up global state. Sourced only on login shells (i.e., whenever a new
# terminal window is opened, but not when `zsh` is invoked on the command line).
if [[ -f "$ZDOTDIR/local/profile-pre.zsh" ]] ; then
    source "$ZDOTDIR/local/profile-pre.zsh"
fi

emulate sh
. ~/.profile
emulate zsh

if [[ -f "$ZDOTDIR/local/profile.zsh" ]] ; then
    source "$ZDOTDIR/local/profile.zsh"
fi

add_local_bin_to_path

