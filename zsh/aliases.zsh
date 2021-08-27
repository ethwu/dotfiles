
# ls
alias ls='ls -GFh'
alias la='ls -a'
alias ll='ls -al'

# exa
if command -v exa &> /dev/null ; then
    alias exa='exa -F'
    alias ls='exa --group-directories-first'
    alias la='ls -a'
    alias ll='ls -lah --git'
    alias lg='ls -laGh --git'
    alias tree='exa --tree'
    alias desc='ls -dlbghH@ --git'
fi

