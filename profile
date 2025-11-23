#ALIASES
alias ls='ls -lFGh'
alias vim='nvim'
alias vimdiff='nvim -d'
alias mup='test `which minikube` && (minikube status || minikube start) && eval $(minikube docker-env)'
alias todos='grep -r --exclude-dir=.git/ --exclude=*.swp TODO .'
alias tython='python -m pytest --tb=auto tests/'

#CREATE ENVIRONMENT VARIABLES
export JAVA_HOME=`/usr/libexec/java_home`
export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR=nvim
export GOPATH=~/go

source $(find /Library/Developer/CommandLineTools -name 'git-prompt.sh' -type f -print -quit 2>/dev/null | perl -pe 'chomp')
export PS1='\h:\W \u$(__git_ps1)$ '

export BREW_HOME=~/Developer/homebrew
export GOROOT=`${BREW_HOME}/bin/go env GOROOT`

#ADD ENVIRONMENT VARIABLES TO THE PATH
export PATH=${BREW_HOME}/bin:${GOPATH}/bin:$(${BREW_HOME}/bin/brew --prefix rustup)/bin:$(${BREW_HOME}/bin/ghcup whereis bindir):${PATH}
