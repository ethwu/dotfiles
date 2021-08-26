local plugins="$XDG_DATA_HOME/zsh/"

# zsh-autosuggestions
source "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh-syntax-highlighting
source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# zsh-history-substring-search
source "$plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=('fg=magenta,bold')
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=('fg=white')

unset plugins

