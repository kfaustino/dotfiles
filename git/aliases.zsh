hub_path=$(which hub)
if (( $+commands[hub] ))
then
  eval "$(hub alias -s)"
fi

alias g='git status -sb'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit -a'
alias gd='git diff'
alias gco='git checkout'
alias gl='git log --oneline --decorate --graph'
