syntax on                       "turn syntax highlighting on

set nocompatible                " don't care about compatibility with old vi
set autoread                    " Automatically read changed files
set number                      " set line numbers
set nowrap                      " don't wrap lines
set laststatus=2                " show status line always
set tabstop=4                   " tab is 4 spaces
set softtabstop=4               " tab is 4 space when inserting
set expandtab                   " On pressing tab, insert 4 spaces
set backspace=indent,eol,start  " allow backspacing over everything in insert
set autoindent                  " always set autoindenting on
set smartindent                 " Asmart autoindenting when starting a new line
set copyindent                  " copy previous indentation on autoindenting
set shiftwidth=4                " number of spaces to use for autoindenting
set showmatch                   " show matching parentheses
set smartcase                   " ignore case if search pattern is all lowercase, case-sensitive otherwise
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set splitright                  " vsplit opens to the right
set splitbelow                  " Horizontal windows should split to bottom
set noshowmode                  " We show the mode with airline or lightline
set completeopt=menu,menuone    " Show popup menu, even if there is one entry
set pumheight=10                " Completion window max size
set mouse=a                     " enable mouse for all modes"

filetype off                    " turn off filetype for vundle
filetype plugin indent on       " file detection

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h

augroup yaml
    autocmd FileType yaml,yml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" Act like D and C
nnoremap Y y$
nnoremap <Leader>a :cclose<CR>
map <Leader>n :cprevious<CR>
map <Leader>m :cnext<CR>

"------------- PLUGINS START -------------
" set runtime path to include Vundle and initilize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'           " plugin manager
Plugin 'nanotech/jellybeans.vim'        " my chosen theme
Plugin 'vim-airline/vim-airline'        " super awesome status bar
Plugin 'vim-airline/vim-airline-themes' " airline themes
Plugin 'scrooloose/NERDTree'            " advanced file browser
Plugin 'majutsushi/tagbar'              " language tag browser
Plugin 'scrooloose/syntastic'           " syntax checking
Plugin 'ctrlpvim/ctrlp.vim'             " file finder
Plugin 'tpope/vim-fugitive'             " git plugin

"---------- Language Specific -----
Plugin 'artur-shaik/vim-javacomplete2'  " java plugin
Plugin 'fatih/vim-go'                   " go plugin
Plugin 'SirVer/ultisnips'               " extra snipits for go
Plugin 'AndrewRadev/splitjoin.vim'      " utilisnip for go
Plugin 'jiangmiao/auto-pairs'           " parens, quote, etc. automatching
Plugin 'uarun/vim-protobuf'             " .proto file syntax highlghting
Plugin 'hashivim/vim-terraform'         " terraform plugin

call vundle#end()
"------------ PLUGINS END --------------

"---------- JELLYBEANS SETTINGS -------
set background=dark
colorscheme jellybeans

"------------ AIRLINE SETTINGS -------
let g:airline_detect_paste = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme = 'jellybeans'

"--------- NERDTREE settings ---------
map <Leader>o :NERDTreeToggle<CR>
augroup ProjectDrawer
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

"----------- TAGBAR SETTINGS ----------
nmap <Leader>p :TagbarToggle<CR>
let g:tagbar_show_linenumbers = 2

"----------- SYNTASTIC SETTINGS -------

"---------- CTRLP SETTINGS ------------

"---------- FUGITIVE SETTINGS ---------

"---- VIM-JAVACOMPLETE2  SETTINGS -----
augroup java
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
    autocmd FileType java nmap <leader>jI <Plug>(JavaComplete-Imports-AddMissing)
    autocmd FileType java nmap <leader>jR <Plug>(JavaComplete-Imports-RemoveUnused)
    autocmd FileType java nmap <leader>ji <Plug>(JavaComplete-Imports-AddSmart)
    autocmd FileType java nmap <leader>jii <Plug>(JavaComplete-Imports-Add)

    autocmd FileType java imap <C-j>I <Plug>(JavaComplete-Imports-AddMissing)
    autocmd FileType java imap <C-j>R <Plug>(JavaComplete-Imports-RemoveUnused)
    autocmd FileType java imap <C-j>i <Plug>(JavaComplete-Imports-AddSmart)
    autocmd FileType java imap <C-j>ii <Plug>(JavaComplete-Imports-Add)

    autocmd FileType java nmap <leader>jM <Plug>(JavaComplete-Generate-AbstractMethods)

    autocmd FileType java imap <C-j>jM <Plug>(JavaComplete-Generate-AbstractMethods)

    autocmd FileType java nmap <leader>jA <Plug>(JavaComplete-Generate-Accessors)
    autocmd FileType java nmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
    autocmd FileType java nmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
    autocmd FileType java nmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
    autocmd FileType java nmap <leader>jts <Plug>(JavaComplete-Generate-ToString)
    autocmd FileType java nmap <leader>jeq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
    autocmd FileType java nmap <leader>jc <Plug>(JavaComplete-Generate-Constructor)
    autocmd FileType java nmap <leader>jcc <Plug>(JavaComplete-Generate-DefaultConstructor)

    autocmd FileType java imap <C-j>s <Plug>(JavaComplete-Generate-AccessorSetter)
    autocmd FileType java imap <C-j>g <Plug>(JavaComplete-Generate-AccessorGetter)
    autocmd FileType java imap <C-j>a <Plug>(JavaComplete-Generate-AccessorSetterGetter)

    autocmd FileType java vmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
    autocmd FileType java vmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
    autocmd FileType java vmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)

    autocmd FileType java nmap <silent> <buffer> <leader>jn <Plug>(JavaComplete-Generate-NewClass)
    autocmd FileType java nmap <silent> <buffer> <leader>jN <Plug>(JavaComplete-Generate-ClassInFile)
augroup END

"----------- VIM-GO SETTINGS-----------
function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0,1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction
augroup go
    autocmd FileType go nmap <Leader>b :<C-u>call <SID>build_go_files()<CR>
    autocmd FileType go nmap <Leader>g <Plug>(go-run)
    autocmd FileType go nmap <Leader>t <Plug>(go-test)
    autocmd FileType go nmap <Leader>s <Plug>(go-alternate-vertical)
    autocmd FileType go nmap <Leader>d <Plug>(go-doc-vertical)
    autocmd FileType go nmap <Leader>db <Plug>(go-doc-browser)
    autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
    autocmd FileType go nmap <Leader>i :GoImpl<CR>
    autocmd FileType go nmap <Leader>r <Plug>(go-rename)
    autocmd FileType go vmap <Leader>f <Plug>(go-freevars)
augroup END

let g:go_list_type = 'quickfix'
let g:go_fmt_command = 'goimports'
let g:go_autodetect_gopath = 1
let g:go_version_warning = 0

"------ UTILINSIPS SETTINGS ---------

"------ SPLITJION SETTINGS --------

"------- AUTO-PAIRS SETTINGS -------
