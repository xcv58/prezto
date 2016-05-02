bindkey -v
bindkey -M viins "^R" history-incremental-pattern-search-backward
bindkey -M vicmd "^R" history-incremental-pattern-search-backward
bindkey -M viins "^S" history-incremental-pattern-search-forward
bindkey -M vicmd "^S" history-incremental-pattern-search-forward
bindkey -M viins "^A" beginning-of-line
bindkey -M vicmd "^A" beginning-of-line
bindkey -M viins "^E" end-of-line
bindkey -M vicmd "^E" end-of-line
bindkey -M viins "^D" delete-char
bindkey -M viins "^H" backward-delete-char
bindkey -M viins "^B" backward-char
bindkey -M viins "^F" forward-char
bindkey -M viins "^U" backward-kill-line
bindkey -M viins "^K" kill-line
bindkey -M vicmd "^K" kill-line
bindkey -M viins "^W" backward-kill-word
bindkey -M vicmd "^W" backward-kill-word
bindkey -M viins "^P" history-beginning-search-backward
bindkey -M viins "^N" history-beginning-search-forward
bindkey -M viins "^[[A" history-beginning-search-backward
bindkey -M viins "^[[B" history-beginning-search-forward
bindkey -M viins "^V" edit-command-line
bindkey -M viins "^L" xcv58-clear-screen
bindkey -M viins "\e." insert-last-word
bindkey -M viins "\e1" insert-first-word
bindkey -M viins "\e2" insert-last-word

function insert-first-word () {
    zle insert-last-word -- -1 1 -
}

zle -N insert-first-word

trapwinch () {
    prepare_first_line
    zle reset-prompt
}

precmd () {
    prompt_xcv58_precmd
    prepare_first_line
}

function xcv58-clear-screen () {
    clear
    prepare_first_line
    zle reset-prompt
}

zle -N xcv58-clear-screen

prepare_first_line () {
    print ""
    local remote_string=""
    if [[ ${SSH_CLIENT} ]] then
        remote_string=" ${_prompt_xcv58_colors[1]}SSH%f"
    fi
    print -rP "${_prompt_xcv58_colors[3]}%n%f@${_prompt_xcv58_colors[2]}%m%f${remote_string} in ${_prompt_xcv58_colors[5]}%~%f ${vcs_info_msg_0_}"
}

vi_mode_indicator () {
    case ${KEYMAP} in
      (vicmd)      echo "%F{red}[% VI]% %r%f" ;;
      (main|viins) echo "" ;;
      (*)          echo "" ;;
    esac
  }

function zle-line-init zle-keymap-select {
    VIM_PROMPT="$(vi_mode_indicator)"
    PS1="${VIM_PROMPT}\$ "
    RPS1="${xcv58_time}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}  $EPS1${RPS1}"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
