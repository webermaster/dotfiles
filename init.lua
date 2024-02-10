vim.cmd('syntax on')                            -- Turn syntax highlighting on

vim.opt.compatible = false                      -- Don't care about compatibility with old vi
vim.opt.autoread = true                         -- Automatically read changed files
vim.opt.number = true                           -- Set line numbers
vim.opt.wrap = false                            -- Don't wrap lines
vim.opt.laststatus = 2                          -- Show status line always
vim.opt.tabstop = 4                             -- Tab is 4 spaces
vim.opt.softtabstop = 4                         -- Tab is 4 space when inserting
vim.opt.expandtab = true                        -- On pressing tab, insert 4 spaces
vim.opt.backspace:append("indent,eol,start")    -- Allow backspacing over everything in insert
vim.opt.autoindent = true                       -- Always set autoindenting on
vim.opt.smartindent = true                      -- Asmart autoindenting when starting a new line
vim.opt.copyindent = true                       -- Copy previous indentation on autoindenting
vim.opt.shiftwidth = 4                          -- Number of spaces to use for autoindenting
vim.opt.showmatch = true                        -- Show matching parentheses
vim.opt.smartcase = true                        -- Ignore case if search pattern is all lowercase, case-sensitive otherwise
vim.opt.hlsearch = true                         -- Highlight search terms
vim.opt.incsearch = true                        -- Show search matches as you type
vim.opt.splitright = true                       -- Vsplit opens to the right
vim.opt.splitbelow = true                       -- Horizontal windows should split to bottom
vim.opt.showmode = false                        -- We show the mode with airline or lightline
vim.opt.completeopt:append("menu")              -- Show popup menu, even if there is one entry
vim.opt.completeopt:append("menuone")           -- Show popup menu, even if there is one entry
vim.opt.pumheight = 10                          -- Completion window max size
vim.opt.mouse = "a"                             -- Enable mouse for all modes
vim.opt.termguicolors = true                    -- Force 256 colors
vim.opt.t_Co = 256                              -- Force 256 colors
vim.opt.encoding = "utf-8"                      -- UTF-8 encoding

vim.cmd('filetype off')                         -- Turn off filetype for vundle

-- Enter automatically into the files directory
vim.cmd('autocmd BufEnter * silent! lcd %:p:h')

-- Set tab settings for specific file types
vim.cmd('augroup yaml')
vim.cmd('    autocmd FileType yaml,yml setlocal tabstop=2 softtabstop=2 shiftwidth=2')
vim.cmd('augroup END')

vim.cmd('augroup cfn_template')
vim.cmd('    autocmd BufNewFile,BufFilePre,BufRead *.template set syntax=yaml')
vim.cmd('    autocmd BufNewFile,BufFilePre,BufRead *.template setlocal tabstop=2 softtabstop=2 shiftwidth=2')
vim.cmd('augroup END')

vim.cmd('augroup xml')
vim.cmd('    autocmd FileType xml setlocal tabstop=2 softtabstop=2 shiftwidth=2')
vim.cmd('augroup END')

vim.cmd('augroup json')
vim.cmd('    autocmd FileType json setlocal tabstop=2 softtabstop=2 shiftwidth=2')
vim.cmd('augroup END')

vim.cmd('augroup tf')
vim.cmd('    autocmd FileType tf setlocal tabstop=2 softtabstop=2 shiftwidth=2')
vim.cmd('augroup END')

vim.cmd('augroup md')
vim.cmd('    autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc')
vim.cmd('augroup END')

-- Act like D and C
vim.api.nvim_set_keymap('n', 'Y', 'y$', {})
vim.api.nvim_set_keymap('n', '<Leader>a', ':cclose<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>n', ':cprevious<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>m', ':cnext<CR>', {})

-- Set runtime path to include Vundle and initialize
vim.o.runtimepath = vim.o.runtimepath .. ',~/.vim/bundle/Vundle.vim'
vim.cmd('call vundle#begin()')

-- Plugins
vim.cmd('Plugin \'VundleVim/Vundle.vim\'')              -- plugin manager
vim.cmd('Plugin \'tpope/vim-fugitive\'')                -- git plugin
vim.cmd('Plugin \'edkolev/tmuxline.vim\'')              -- vim-airline like tmux bar
vim.cmd('Plugin \'vim-airline/vim-airline\'')           -- super awesome status bar
vim.cmd('Plugin \'vim-airline/vim-airline-themes\'')    -- status bar themes
vim.cmd('Plugin \'nanotech/jellybeans.vim\'')           -- my chosen theme
vim.cmd('Plugin \'scrooloose/NERDTree\'')               -- advanced files browser
vim.cmd('Plugin \'majutsushi/tagbar\'')                 -- language tag browser
vim.cmd('Plugin \'scrooloose/syntastic\'')              -- syntax checking
vim.cmd('Plugin \'ctrlpvim/ctrlp.vim\'')                -- file finder

-- Language specific plugins
vim.cmd('Plugin \'fatih/vim-go\'')                      -- go plugin
vim.cmd('Plugin \'hashivim/vim-terraform\'')            -- terraform plugin
vim.cmd('Plugin \'uarun/vim-protobuf\'')                -- .proto file syntax highlighting
vim.cmd('Plugin \'SirVer/ultisnips\'')                  -- extras snipits for go
vim.cmd('Plugin \'AndrewRadev/splitjoin.vim\'')         -- utilisnip for go

vim.cmd('call vundle#end()')
vim.cmd('filetype plugin indent on')                    -- file detection

-- Jellybeans settings
vim.g.colors_name = 'jellybeans'

-- TmuxLine settings
vim.g.tmuxline_separators = {
    left = '',
    left_alt = '',
    right = '',
    right_alt = '',
    space = ' '
}

-- Airline settings
vim.g.airline_detect_paste = 1
vim.g.airline_extensions_tabline_enabled = 1
vim.g.airline_extensions_tabline_fnamemod = ':t'
vim.g.airline_extensions_branch_enabled = 1
vim.g.airline_extensions_branch_empty_message = ''
vim.g.airline_extensions_branch_displayed_head_limit = 10
vim.g.airline_extensions_branch_format = 2
vim.g.airline_theme = 'jellybeans'

-- NERDTree settings
vim.api.nvim_set_keymap('n', '<Leader>o', ':NERDTreeToggle<CR>', {})
vim.cmd('augroup ProjectDrawer')
vim.cmd('    autocmd StdinReadPre * let s:std_in=1')
vim.cmd('    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe \'NERDTree\' argv()[0] | wincmd p | ene | endif')
vim.cmd('    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif')
vim.cmd('augroup END')

-- TAGBAR settings
vim.api.nvim_set_keymap('n', '<Leader>p', ':TagbarToggle<CR>', {})
vim.g.tagbar_show_linenumbers = 2

-- VIM-GO settings
vim.cmd([[
function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0,1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction
]])
vim.cmd('augroup go')
vim.cmd('    autocmd FileType go nmap <Leader>b :<C-u>call <SID>build_go_files()<CR>')
vim.cmd('    autocmd FileType go nmap <Leader>g <Plug>(go-run)')
vim.cmd('    autocmd FileType go nmap <Leader>t <Plug>(go-test)')
vim.cmd('    autocmd FileType go nmap <Leader>s <Plug>(go-alternate-vertical)')
vim.cmd('    autocmd FileType go nmap <Leader>d <Plug>(go-doc-vertical)')
vim.cmd('    autocmd FileType go nmap <Leader>db <Plug>(go-doc-browser)')
vim.cmd('    autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)')
vim.cmd('    autocmd FileType go nmap <Leader>i :GoImpl<CR>')
vim.cmd('    autocmd FileType go nmap <Leader>r <Plug>(go-rename)')
vim.cmd('    autocmd FileType go vmap <Leader>f <Plug>(go-freevars)')
vim.cmd('augroup END')

vim.g.go_list_type = 'quickfix'
vim.g.go_fmt_command = 'goimports'
vim.g.go_autodetect_gopath = 1
vim.g.go_version_warning = 0
vim.g.go_metalinter_autosave = 1
vim.g.go_auto_sameids = 1

-- VIM-MARKDOWN
vim.g.markdown_fenced_languages = {'go', 'python', 'bash=sh', 'java', 'haskell', 'clojure'}
vim.g.markdown_syntax_conceal = 0

-- VIM-TERRAFORM
vim.g.terraform_fmt_on_save = 1

