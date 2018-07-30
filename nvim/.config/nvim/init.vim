set lazyredraw
set noswapfile

set number relativenumber
set smartindent
set nohlsearch
set ignorecase
set smartcase

filetype plugin indent on
syntax on

""""""""""""""""
" Keybindings  
""""""""""""""""
let mapleader = ','
let g:mapleader=','

" copy and paste to/from clipboard
map <leader>y "*y
map <leader>p "*p

noremap <leader>w :w<cr>
noremap <leader>q :q!<cr>
noremap <leader>x :x<cr>
