
local cmd = vim.cmd
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

cmd('syntax on')                          -- Turn syntax highlighting on
cmd('filetype plugin indent on')          -- file detection

-- Set tab settings for specific file types
augroup('yaml', {
    clear = false
})
autocmd({'FileType'}, {
    group = 'yaml',
    pattern = {'yaml', 'yml'},
    command = 'setlocal tabstop=2 softtabstop=2 shiftwidth=2'
})

augroup('xml', {
    clear = false
})
autocmd({'FileType'}, {
    group = 'xml',
    pattern = {'xml'},
    command = 'setlocal tabstop=2 softtabstop=2 shiftwidth=2'
})

augroup('json', {
    clear = false
})
autocmd({'FileType'}, {
    group = 'json',
    pattern = {'json'},
    command = 'setlocal tabstop=2 softtabstop=2 shiftwidth=2'
})

augroup('tf', {
    clear = false
})
autocmd({'FileType'}, {
    group = 'tf',
    pattern = {'tf'},
    command = 'setlocal tabstop=2 softtabstop=2 shiftwidth=2'
})

augroup('lua', {
    clear = false
})
autocmd({'FileType'}, {
    group = 'lua',
    pattern = {'lua'},
    command = 'setlocal tabstop=2 softtabstop=2 shiftwidth=2'
})

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
