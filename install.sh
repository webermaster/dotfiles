#!/bin/sh

#make may for fresh install
BREWDIR=~/Developer/homebrew
mv ~/.profile ~/.profile.old
rm -rf $BREWDIR

#install Homebrew
mkdir -p $BREWDIR && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C $BREWDIR

#install brew cask
BREW=~/Developer/homebrew/bin/brew
$BREW tap caskroom/cask

#install kegs
$BREW install vim
$BREW install watch
$BREW install maven
$BREW install go
$BREW install --HEAD universal-ctags/universal-ctags/universal-ctags
$BREW install kubectl
$BREW install docker
$BREW install awscli
$BREW install kubernetes-helm

#install casks
$BREW cask install java
$BREW cask install intellij-idea-ce
$BREW cask install slack
$BREW cask install google-cloud-sdk

#setup environment installed by brew
CELLAR=$BREWDIR/Cellar
GOP=`cd $CELLAR/go/* && echo "${PWD##*/}"`

cat << EOF >> ~/.profile

#ALIASES
alias ls='ls -lFGh'
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'

#CREATE ENVIRONMENT VARIABLES
export JAVA_HOME=`/usr/libexec/java_home`
export GOPATH=~/Documents/go

export BREW_HOME=~/Developer/homebrew
CELLAR=\$BREW_HOME/Cellar

#ADD ENVIRONMENT VARIABLES TO THE PATH
export PATH=\$BREW_HOME/bin:\$PATH:\\
\$GOROOT/bin:\\
\$GOPATH/bin

EOF

#symlink .vimrc
ln -s "$(cd "$(dirname "$0")"; pwd -P )"/vimrc ~/.vimrc

#install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#get plugins
vim -c 'PluginInstall' -c 'GoInstallBinaries' -c 'qa!'

#setup go workspace
mkdir -p ~/Documents/go/src
mkdir -p ~/Documents/go/bin
mkdir -p ~/Documents/go/pkg
