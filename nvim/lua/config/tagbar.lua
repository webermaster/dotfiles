local g = vim.g
local keymap = vim.keymap.set

-- TAGBAR settings
keymap('n', '<Leader>p', ':TagbarToggle<CR>', {})
g.tagbar_show_linenumbers = 2
