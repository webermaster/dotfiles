local cmd = vim.cmd
local keymap = vim.keymap.set

-- NERDTree settings
keymap('n', '<Leader>o', ':NERDTreeToggle<CR>', {})
cmd('augroup ProjectDrawer')
cmd('    autocmd StdinReadPre * let s:std_in=1')
cmd('    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe \'NERDTree\' argv()[0] | wincmd p | ene | endif')
cmd('    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif')
cmd('augroup END')
