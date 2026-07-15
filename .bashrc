# git
alias gac="git add . && git commit -m"
# ~/.local/bin (mise, jupyter, starship) — .profile only adds it in login shells
export PATH="$HOME/.local/bin:$PATH"
# mise
eval "$(~/.local/bin/mise activate bash)"
# starship
eval "$(starship init bash)"
# go install binaries (gopls, dlv)
export PATH="$PATH:$HOME/go/bin"
