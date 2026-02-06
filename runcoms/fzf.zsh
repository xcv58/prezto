# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------

[ -f "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" ] && source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

# Rebind fzf file widget from Ctrl+T to Alt+T
bindkey -M emacs '\et' fzf-file-widget
bindkey -M vicmd '\et' fzf-file-widget
bindkey -M viins '\et' fzf-file-widget
bindkey -M emacs -r '^T'
bindkey -M vicmd -r '^T'
bindkey -M viins -r '^T'
