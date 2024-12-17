
local cmd = vim.cmd
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

cmd('syntax on')                          -- Turn syntax highlighting on
cmd('filetype plugin indent on')          -- file detection

