# git
alias gac="git add . && git commit -m"
# mise
eval "$(~/.local/bin/mise activate bash)"
# starship
eval "$(starship init bash)"
# go install binaries (gopls, dlv)
export PATH="$PATH:$HOME/go/bin"
