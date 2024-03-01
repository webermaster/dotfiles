#!/bin/sh

#make way for fresh install
BREWDIR=~/Developer/homebrew
rm  ~/.profile
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.tmux
rm  ~/.tmux.conf
rm -rf ${BREWDIR}

#install Homebrew
mkdir -p ${BREWDIR} && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ${BREWDIR}

#alias brew executable for rest of script
BREW=${BREWDIR}/bin/brew

# Install tools
${BREW} bundle --file "$(cd "$(dirname "$0")"; pwd -P )"/Brewfile
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | BOOTSTRAP_HASKELL_NONINTERACTIVE=1 sh
sudo ln -sfn ~/Developer/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

#setup environment installed by brew
CELLAR=${BREWDIR}/Cellar
GOP=`cd ${CELLAR}/go/* && echo "${PWD##*/}"`

#symlink profile
ln -s "$(cd "$(dirname "$0")"; pwd -P )"/profile ~/.profile
ln -s "$(cd "$(dirname "$0")"; pwd -P )"/profile ~/.bashrc

#symlink .vimrc
ln -s "$(cd "$(dirname "$0")"; pwd -P )"/nvim ~/.config/nvim/
ln -s "$(cd "$(dirname "$0")"; pwd -P )"/vimrc ~/.vimrc

#symlink .tmux.conf
ln -s "$(cd "$(dirname "$0")"; pwd -P )"/tmux.conf ~/.tmux.conf

# install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#get plugins
${BREWDIR}/bin/nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
${BREWDIR}/bin/vim -c 'PluginInstall' -c 'qa!'

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
