local cmd = vim.cmd

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

-- Reload configurations if we modify plugins.lua
-- Hint
--     <afile> - replaced with the filename of the buffer being manipulated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'            -- packer itself
  use 'williamboman/mason.nvim'           -- lsp packe manager
  use 'williamboman/mason-lspconfig.nvim' -- lsp-mason integration
  use 'neovim/nvim-lspconfig'             -- convenient lsp configs for native client
  use 'tpope/vim-fugitive'                -- git plugin
  use 'edkolev/tmuxline.vim'              -- vim-airline like tmux bar
  use 'vim-airline/vim-airline'           -- super awesome status bar
  use 'vim-airline/vim-airline-themes'    -- status bar themes
  use 'nanotech/jellybeans.vim'           -- my chosen theme
  use 'scrooloose/NERDTree'               -- advanced files browser
  use 'preservim/tagbar'                  -- language tag browser
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
