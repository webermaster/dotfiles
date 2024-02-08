#!/bin/sh

#make way for fresh install
BREWDIR=~/Developer/homebrew
rm  ~/.profile
rm -rf ~/.vim
rm  ~/.vimrc
rm -rf ~/.tmux
rm  ~/.tmux.conf
rm -rf $BREWDIR

#install Homebrew
mkdir -p $BREWDIR && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C $BREWDIR

#alias brew executable for rest of script
BREW=${BREWDIR}/bin/brew

#java
$BREW install java
sudo ln -sfn ~/Developer/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
$BREW install maven

brew bundle --file "$(cd "$(dirname "$0")"; pwd -P )"/Brewfile


#setup environment installed by brew
CELLAR=$BREWDIR/Cellar
GOP=`cd $CELLAR/go/* && echo "${PWD##*/}"`

cat << EOF >> ~/.profile

#ALIASES
alias ls='ls -lFGh'
alias mup='test `which minikube` && (minikube status || minikube start) && eval $(minikube docker-env)'
alias todos='grep -r --exclude-dir=.git/ --exclude=*.swp TODO .'

#CREATE ENVIRONMENT VARIABLES
export JAVA_HOME=`/usr/libexec/java_home`
export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR=vim
export GOPATH=~/go

source \$(find / -name 'git-prompt.sh' -type f -print -quit 2>/dev/null | perl -pe 'chomp')
export PS1='\h:\W \u$(__git_ps1)\$ '

export BREW_HOME=~/Developer/homebrew
CELLAR=\$BREW_HOME/Cellar

#ADD ENVIRONMENT VARIABLES TO THE PATH
export PATH=\$BREW_HOME/bin:\$GOPATH/bin:\$PATH
EOF

#symlink .vimrc
ln -s "$(cd "$(dirname "$0")"; pwd -P )"/vimrc ~/.vimrc

#symlink .tmux.conf
ln -s "$(cd "$(dirname "$0")"; pwd -P )"/tmux.conf ~/.tmux.conf

#install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#get plugins
vim -c 'PluginInstall' -c 'GoInstallBinaries' -c 'qa!'

#setup go workspace
mkdir -p ~/go/src
mkdir -p ~/go/bin
mkdir -p ~/go/pkg

#set git preferences
cat << EOF > ~/.gitignore_global
*~
.*.swp
.DS_Store
EOF
git config --global core.editor vim
git config --global core.autocrlf input
git config --global core.excludesfile ~/.gitignore_global
git config --global merge.tool vimdiff
git config --global merge.conflictstyle diff3
