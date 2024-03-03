require('webermaster.options')
require('webermaster.filetypes')
require('webermaster.keymaps')

require('webermaster.lazy_init')

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local WebermasterGroup = augroup('Webermaster', {})

autocmd({'BufWritePre'}, {
    group = WebermasterGroup,
    pattern = '*',
    command = [[%s/\s\+$//e]],
})
