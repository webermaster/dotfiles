local keymap = vim.keymap.set

-- Act like D and C
keymap('n', 'Y', 'y$', {})
keymap('n', '<Leader>a', ':cclose<CR>', {})
keymap('n', '<Leader>n', ':cprevious<CR>', {})
keymap('n', '<Leader>m', ':cnext<CR>', {})

-- open terminal
keymap('n', '<Leader>z', ':new<CR>:terminal<CR>', {})
