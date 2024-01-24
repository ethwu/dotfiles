
# ls
alias ls='ls -GFh'
alias la='ls -a'
alias ll='ls -al'

# eza
if command -v eza &> /dev/null ; then
    alias eza='eza -Fb'
    alias ls='eza --group-directories-first'
    alias la='ls -a'
    alias ll='ls -lah --git'
    alias lg='ls -laGh --git'
    alias tree='eza --tree'
    alias desc='ls -dlbghH@ --git'
fi

if command -v ranger &> /dev/null ; then
    alias R=ranger
fi

if command -v nvim &> /dev/null ; then
    alias vim=nvim
fi

if command -v just &> /dev/null ; then
    alias j=just
fi
