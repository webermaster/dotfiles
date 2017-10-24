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

set mouse=a

filetype off " turn off filetype for vundle

" set runtime path to include Vundle and initilize
set rtp+=~/.vim/bundle/Vundle.vim

"------------- PLUGINS START -------------
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'nanotech/jellybeans.vim'

call vundle#end()
"------------ PLUGINS END --------------
filetype plugin indent on

"------------ AIRLINE SETTINGS -------
set laststatus=2 " show status line always
let g:airline_detect_paste=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='jellybeans'
colorscheme jellybeans

"------------ NERDTREE SETTINGS ---------
map <silent> <leader>t :NERDTreeToggle<CR>

"------------ SYNTASTIC SETTINGS -------
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
