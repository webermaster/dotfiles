local cmd = vim.cmd

-- Set runtime path to include Vundle and initialize
vim.o.runtimepath = vim.o.runtimepath .. ',~/.vim/bundle/Vundle.vim'
cmd('call vundle#begin()')

-- Plugins
cmd('Plugin \'VundleVim/Vundle.vim\'')              -- plugin manager
cmd('Plugin \'tpope/vim-fugitive\'')                -- git plugin
cmd('Plugin \'edkolev/tmuxline.vim\'')              -- vim-airline like tmux bar
cmd('Plugin \'vim-airline/vim-airline\'')           -- super awesome status bar
cmd('Plugin \'vim-airline/vim-airline-themes\'')    -- status bar themes
cmd('Plugin \'nanotech/jellybeans.vim\'')           -- my chosen theme
cmd('Plugin \'scrooloose/NERDTree\'')               -- advanced files browser
cmd('Plugin \'majutsushi/tagbar\'')                 -- language tag browser
cmd('Plugin \'scrooloose/syntastic\'')              -- syntax checking
cmd('Plugin \'ctrlpvim/ctrlp.vim\'')                -- file finder

-- Language specific plugins
cmd('Plugin \'fatih/go\'')                          -- go plugin
cmd('Plugin \'hashivim/vim-terraform\'')            -- terraform plugin
cmd('Plugin \'uarun/vim-protobuf\'')                -- .proto file syntax highlighting
cmd('Plugin \'SirVer/ultisnips\'')                  -- extras snipits for go
cmd('Plugin \'AndrewRadev/splitjoin.vim\'')         -- utilisnip for go

cmd('call vundle#end()')
cmd('filetype plugin indent on')                    -- file detection
