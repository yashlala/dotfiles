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
map <leader>c "+y
map <leader>v "+p

map <leader>w :w<cr>
map <leader>q :q!<cr>
map <leader>x :x<cr>


