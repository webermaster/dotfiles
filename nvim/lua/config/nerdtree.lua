local keymap = vim.keymap.set
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- NERDTree settings
keymap('n', '<Leader>o', ':NERDTreeToggle<CR>', {})
augroup('ProjectDrawer', {
    clear = false
})
autocmd({'StdinReadPre'}, {
    group = 'ProjectDrawer',
    pattern = {'*'},
    command = 'let s:std_in=1'
})
autocmd({"VimEnter"}, {
  group = 'ProjectDrawer',
  nested = true,
  pattern = {'*'},
  command = 'if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe \'NERDTree\' argv()[0] | wincmd p | ene | endif'
})
autocmd({"BufEnter"}, {
  group = 'ProjectDrawer',
  nested = true,
  command = 'if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif'
})
