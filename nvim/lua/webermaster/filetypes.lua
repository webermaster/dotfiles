
local cmd = vim.cmd
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

cmd('syntax on')                          -- Turn syntax highlighting on
cmd('filetype plugin indent on')          -- file detection

augroup('cfn_template', {
    clear = false
})
autocmd({'BufNewFile','BufFilePre','BufRead'}, {
    group = 'cfn_template',
    pattern = {'*.template'},
    command = 'set filetype=yaml'
})
autocmd({'FileType'}, {
    group = 'cfn_template',
    pattern = {'template'},
    command = 'setlocal tabstop=2 softtabstop=2 shiftwidth=2'
})
