syntax on "turn syntax highlighting on
set nocompatible
set number " set line numbers
set nowrap " don't wrap lines
set tabstop=4 " tab is 4 spaces
set expandtab " On pressing tab, insert 4 spaces
set backspace=indent,eol,start " allow backspacing over everything in insert
set autoindent " always set autoindenting on
set smartindent
set copyindent " copy previous indentation on autoindenting
set shiftwidth=4 " number of spaces to use for autoindenting
set showmatch " show matching parentheses
set smartcase " ignore case if search pattern is all lowercase, case-sensitive otherwise
set hlsearch " highlight search terms
set incsearch " show search matches as you type
set splitright " vsplit opens to the right

set mouse=a

filetype off " turn off filetype for vundle

" set runtime path to include Vundle and initilize
set rtp+=~/.vim/bundle/Vundle.vim

"------------- PLUGINS START -------------
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/NERDTree'
Plugin 'majutsushi/tagbar'
Plugin 'nanotech/jellybeans.vim'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'

"---------- Language Specific -----
Plugin 'fatih/vim-go'
Plugin 'SirVer/ultisnips'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'jiangmiao/auto-pairs'

call vundle#end()
"------------ PLUGINS END --------------
filetype plugin indent on

"------ CLASSIC BRACKET COMPLETION ---

"------------ AIRLINE SETTINGS -------
set laststatus=2 " show status line always
let g:airline_detect_paste = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
set background=dark
let g:airline_theme = 'jellybeans'
colorscheme jellybeans

"--------- NERDTREE settings ---------
map <Leader>p :NERDTreeToggle<CR>
augroup ProjectDrawer
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

"----------- TAGBAR SETTINGS -----------
nmap <Leader>o :TagbarToggle<CR>
let g:tagbar_show_linenumbers = 2

"------------ SYNTASTIC SETTINGS -------

"----------- VIM-GO -------------------
map <Leader>n :cprevious<CR>
map <Leader>m :cnext<CR>
nnoremap <Leader>a :cclose<CR>
function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0,1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction
ino " ""<left>
ino ' ''<left>
ino ` ``<left>
ino ( ()<left>
ino [ []<left>
ino { {}<left>
ino {<CR> {<CR>}<ESC>O
ino {;<CR> {<CR>};<ESC>O
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

let g:go_list_type = 'quickfix'
let g:go_fmt_command = 'goimports'
let g:go_auto_type_info = 1
let g:go_version_warning = 0
