#
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/dredo/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/dredo/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/dredo/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/dredo/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> FZF >>>
source <(fzf --zsh)
# <<< FZF <<<

# >>> Oh My Posh >>>
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/tokio.json)"
fi
# <<< Oh My Posh <<<

# >>> ZSH History >>>
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_save_no_dups
setopt hist_ignore_dups
# <<< ZSH History <<<

# >>> Eza (better ls) >>>
alias ls="eza --color=always --long --git --icons=always --no-permissions"
# <<< Eza (better ls) <<<

# >>> Zoxide >>>
eval "$(zoxide init zsh)"
alias cd="z"
# <<< Zoxide <<<

# >>> Yazi >>>
export EDITOR="nvim"

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}
# <<< Yazi <<<

# >>> thefuck alias >>>
eval $(thefuck --alias)
# <<< thefuck alias <<<
