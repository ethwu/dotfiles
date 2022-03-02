# prompt.zsh
# ----------

if ! [[ "$ZSH_EVAL_CONTEXT" =~ :file$ ]] ; then
    echo 'prompt.zsh'
    echo
    echo 'Usage:'
    echo '    source prompt.zsh [options]'
    echo
    echo 'Options:'
    echo '    --user      Show the username in the prompt.'
    echo '    --host      Show the hostname in the prompt.'
    echo '    --elapsed   Show the time elapsed during commands.'
    echo '    --vcs       Show VCS information when applicable.'
    exit 1
fi

zparseopts -D -E -F \
    -user=show_user \
    -host=show_host \
    -elapsed=show_elapsed \
    -vcs=show_vcs

local end_opts=$@[(i)(--|-)]
set -- "${@[0, end_opts - 1]}" "${@[end_opts + 1, -1]}"

export PROMPT=
export RPROMPT=

PROMPT="%F{red}%? %F{default}["

if [[ "$show_user" ]] ; then
    PROMPT+="%F{green}%n"
    if [[ "$show_host" ]] ; then
        PROMPT+="%F{yellow}@"
    fi
fi

if [[ "$show_host" ]] ; then
    PROMPT+="%F{green}%m"
fi

if [[ "$show_user" ]] || [[ "$show_host" ]] ; then
    PROMPT+="%F{yellow}:"
fi

PROMPT+="%F{green}%-2>…>%(4~|%-1~/…%2~|%~)%>>%F{default}] "

if [[ "$show_vcs" ]] ; then
    autoload -Uz vcs_info
    zstyle ':vcs_info:*:*' formats "%b%c%u "
    zstyle ':vcs_info:*:*' actionformats "%b%c%u (%a) "
    zstyle ':vcs_info:*:*' stagedstr "+"
    zstyle ':vcs_info:*:*' unstagedstr "*"
    zstyle ':vcs_info:*:*' check-for-changes true
    zstyle ':vcs_info:*' enable git

    PROMPT+="%-10(l::
%F{green}%m%F{yellow}:)%(1v.%F{cyan}%1v%f.)"
fi

PROMPT+="%-20(l::
)%F{red}%h %(?.%F{blue}.%F{red})%# %F{default}"

if [[ "$show_elapsed" ]] ; then
    function preexec() {
        timer="$SECONDS"
        cmd="$1"
    }
fi

function precmd() {
    psvar=()

    if [[ "$show_elapsed" ]] && [[ "$cmd" ]] ; then
        cmd=

        local now="$SECONDS"
        local elapsed=$((now - timer))

        RPROMPT="%F{yellow}"
        if [[ $elapsed -gt 86400 ]] ; then
            local days=$((elapsed / 86400))
            elapsed=$((elapsed % 86400))
            if [[ $days -gt 0 ]] ; then
                if [[ "$RPROMPT" != "%F{yellow}" ]] ; then
                    RPROMPT+=' '
                fi
                RPROMPT+="${days}d"
            fi
        fi

        if [[ $elapsed -gt 3600 ]] ; then
            local hours=$((elapsed / 3600))
            elapsed=$((elapsed % 3600))
            if [[ $hours -gt 0 ]] ; then
                if [[ "$RPROMPT" != "%F{yellow}" ]] ; then
                    RPROMPT+=' '
                fi
                RPROMPT+="${hours}h"
            fi
        fi

        if [[ $elapsed -gt 60 ]] ; then
            local minutes=$((elapsed / 60))
            elapsed=$((elapsed % 60))
            if [[ $hours -gt 0 ]] ; then
                if [[ "$RPROMPT" != "%F{yellow}" ]] ; then
                    RPROMPT+=' '
                fi
                RPROMPT+="${minutes}m"
            fi
        fi

        if [[ $elapsed -gt 0 ]] ; then
            if [[ "$RPROMPT" != "%F{yellow}" ]] ; then
                RPROMPT+=' '
            fi
            RPROMPT+="${elapsed}s"
        fi

        RPROMPT+="%{$reset_color%}"
    fi

if [[ "$show_vcs" ]] ; then
    vcs_info
        [[ -n $vcs_info_msg_0_ ]] && print -v 'psvar[1]' -Pr -- "$vcs_info_msg_0_"
    fi

    if [[ `print -P "$PROMPT" | wc -l` -gt 1 ]] ; then
        print ""
    fi
}

unset endopts

