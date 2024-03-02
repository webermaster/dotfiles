require('webermaster.options')
require('webermaster.filetypes')
require('webermaster.keymaps')

require('webermaster.lazy_init')

local augroup = vim.api.nvim_create_augroup
local WebermasterGroup = augroup('Webermaster', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = WebermasterGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
