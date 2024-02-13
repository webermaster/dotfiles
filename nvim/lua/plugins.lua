local cmd = vim.cmd

cmd('filetype off')                       -- Turn off filetype for vundle
cmd('filetype plugin indent on')                    -- file detection
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'            -- packer itself
  use 'tpope/vim-fugitive'                -- git plugin
  use 'edkolev/tmuxline.vim'              -- vim-airline like tmux bar
  use 'vim-airline/vim-airline'           -- super awesome status bar
  use 'vim-airline/vim-airline-themes'    -- status bar themes
  use 'nanotech/jellybeans.vim'           -- my chosen theme
  use 'scrooloose/NERDTree'               -- advanced files browser
  use 'preservim/tagbar'                 -- language tag browser
  use 'scrooloose/syntastic'              -- syntax checking
  use 'ctrlpvim/ctrlp.vim'                -- file finder

  -- Language specific plugins
  use 'fatih/vim-go'                      -- go plugin
  use 'hashivim/vim-terraform'            -- terraform plugin
  use 'uarun/vim-protobuf'                -- .proto file syntax highlighting
  use 'SirVer/ultisnips'                  -- extras snipits for go
  use 'AndrewRadev/splitjoin.vim'         -- utilisnip for go

  if packer_bootstrap then
    require('packer').sync()
  end
end)

--[[
-- Set runtime path to include Vundle and initialize
--cmd('filetype off')                       -- Turn off filetype for vundle
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
--]]
--cmd('filetype plugin indent on')                    -- file detection
