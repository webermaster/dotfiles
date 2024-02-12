
local cmd = vim.cmd
local o = vim.opt
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local keymap = vim.keymap.set


require('options')
require('filetypes')
require('keymaps')
require('plugins')
require('colorscheme')

require('config.tmuxline')
require('config.vim-airline')
require('config.nerdtree')
require('config.tagbar')
require('config.vim-go')
require('config.vim-terraform')

