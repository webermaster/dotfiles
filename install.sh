#!/bin/sh

#make way for fresh install
BREWDIR=~/Developer/homebrew
rm  ~/.profile
rm -rf ~/.config/nvim
rm -rf ~/.tmux
rm  ~/.tmux.conf
rm -rf ${BREWDIR}

#install Homebrew
mkdir -p ${BREWDIR} && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ${BREWDIR}

#alias brew executable for rest of script
BREW=${BREWDIR}/bin/brew

${BREW} bundle --file "$(cd "$(dirname "$0")"; pwd -P )"/Brewfile

sudo ln -sfn ~/Developer/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

#setup environment installed by brew
CELLAR=${BREWDIR}/Cellar
GOP=`cd ${CELLAR}/go/* && echo "${PWD##*/}"`

cat << EOF >> ~/.profile

#ALIASES
alias ls='ls -lFGh'
alias vim='nvim'
alias mup='test `which minikube` && (minikube status || minikube start) && eval $(minikube docker-env)'
alias todos='grep -r --exclude-dir=.git/ --exclude=*.swp TODO .'

#CREATE ENVIRONMENT VARIABLES
export JAVA_HOME=`/usr/libexec/java_home`
export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR=vim
export GOPATH=~/go

source \$(find /Library/Developer/CommandLineTools -name 'git-prompt.sh' -type f -print -quit 2>/dev/null | perl -pe 'chomp')
export PS1='\h:\W \u$(__git_ps1)\$ '

export BREW_HOME=~/Developer/homebrew

#ADD ENVIRONMENT VARIABLES TO THE PATH
export PATH=\${BREW_HOME}/bin:\${GOPATH}/bin:\${PATH}
EOF

#symlink .vimrc
ln -s "$(cd "$(dirname "$0")"; pwd -P )"/nvim ~/.config/nvim/

#symlink .tmux.conf
ln -s "$(cd "$(dirname "$0")"; pwd -P )"/tmux.conf ~/.tmux.conf

#symlink .tmux-statusline-colors.conf
ln -s "$(cd "$(dirname "$0")"; pwd -P )"/tmux-statusline-colors.conf ~/.tmux/.tmux-statusline-colors.conf

#install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#get plugins
vim -c 'PluginInstall' -c 'GoInstallBinaries' -c 'qa!'

#setup neovim python3 venv
${BREWDIR}/bin/python3 -m venv ~/.config/nvim/.venv/
source ~/.config/nvim/.venv/bin/activate
~/.config/nvim/.venv/bin/pip3 install neovim
deactivate

#setup go workspace
mkdir -p ~/go/src
mkdir -p ~/go/bin
mkdir -p ~/go/pkg

#set git preferences
cat << EOF > ~/.gitignore_global
*~
.*.swp
.DS_Store
**/.venv/
EOF
git config --global core.editor vim
git config --global core.autocrlf input
git config --global core.excludesfile ~/.gitignore_global
git config --global merge.tool vimdiff
git config --global merge.conflictstyle diff3
