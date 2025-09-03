#!/bin/sh

#make way for fresh install
BREWDIR=~/Developer/homebrew
rm  ~/.profile
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ${BREWDIR}

DOTFILES=$(cd "$(dirname "$0")"; pwd -P )

#install Homebrew
mkdir -p ${BREWDIR} && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ${BREWDIR}

#alias brew executable for rest of script
BREW=${BREWDIR}/bin/brew

# Install tools
${BREW} bundle --file "${DOTFILES}"/Brewfile
sudo ln -sfn ~/Developer/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

#setup environment installed by brew
CELLAR=${BREWDIR}/Cellar
GOP=`cd ${CELLAR}/go/* && echo "${PWD##*/}"`

#symlink profile
ln -s "${DOTFILES}"/profile ~/.profile
ln -s "${DOTFILES}"/profile ~/.bashrc

#symlink neovim config
mkdir -p ~/.config
ln -s "${DOTFILES}"/nvim ~/.config

#symlink .alacritty.toml
ln -s "${DOTFILES}"/alacritty.conf ~/.config/alacritty.toml

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
