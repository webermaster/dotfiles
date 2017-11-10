#!/bin/sh

#setup initial .profile
cat << EOF > ~/.profile

#ALIASES
alias ls='ls -lFGh'
EOF

#install Homebrew
BREWDIR=~/Developer/homebrew
mkdir -p $BREWDIR && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C $BREWDIR

#install brew cask
BREW=~/Developer/homebrew/bin/brew
$BREW tap caskroom/cask

#install kegs
$BREW cask install java
$BREW install maven
$BREW install go
$BREW install python3
$BREW install node
$BREW install --HEAD universal-ctags/universal-ctags/universal-ctags
$BREW cask install intellij-idea-ce
$BREW cask install slack

#setup environment installed by brew
GOVER=`[[ `$BREWDIR/Cellar/go/*/bin/go version` =~ [a-zA-Z]*([0-9]*\.[0-9]*\.[0-9]*).*  ]] && echo ${BASH_REMATCH[1]}`
CTAGP=`cd $BREWDIR/universal-ctags/HEAD-* && echo "${PWD##*/}"`

cat << EOF >> ~/.profile

#CREATE ENVIRONMENT VARIABLES
export JAVA_HOME=`/usr/libexec/java_home -v 9`
export GOPATH=~/Documents/go

export BREW_HOME=~/Developer/homebrew
CELLAR=\$BREW_HOME/Cellar

export GOROOT=\$CELLAR/go/$GOVER
export CTAGS_HOME=\$CELLAR/universal-ctags/$CTAGP

#ADD ENVIRONMENT VARIABLES TO THE PATH
export PATH=\$CTAGS_HOME/bin:$PATH:\
\$BREW_HOME/bin:\
\$GOROOT/bin:\
\$GOPATH/bin

EOF
#symlink .vimrc
ln -s ./vimrc ~/.vimrc

#install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#get plugins
vim -c 'PluginInstall' -c 'qa!'

