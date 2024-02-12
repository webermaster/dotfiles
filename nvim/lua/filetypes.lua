
local cmd = vim.cmd
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

cmd('filetype off')                       -- Turn off filetype for vundle

-- Enter automatically into the files directory
autocmd({'BufEnter'}, {
    pattern = {'*'},
    command = 'silent! lcd %:p:h'
})

-- Set tab settings for specific file types
augroup('yaml', {
    clear = false
})
autocmd({'FileType'}, {
    group = 'yaml',
    pattern = {'yaml', 'yaml'},
    command = 'setlocal tabstop=2 softtabstop=2 shiftwidth=2'
})

augroup('cfn_template', {
    clear = false
})
autocmd({'BufNewFile','BufFilePre','BufRead'}, {
    group = 'cfn_template',
    pattern = {'*.template'},
    command = 'set syntax=yaml'
})
autocmd({'BufNewFile','BufFilePre','BufRead'}, {
    group = 'cfn_template',
    pattern = {'*.template'},
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
