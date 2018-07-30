set lazyredraw
set noswapfile

set number relativenumber
set smartindent
set nohlsearch
set ignorecase
set smartcase

set wrap
set linebreak
set breakindent
let &showbreak = '↳ '

filetype plugin indent on
syntax on

"""""""""""""""""""
" Keybindings  
"""""""""""""""""""
nnoremap <cr> o<esc>
nnoremap <space> :

let mapleader = ','
let g:mapleader= ','

"""""""""""""""""""
" Leader Commands
"""""""""""""""""""
noremap <leader>y "*y
noremap <leader>p "*p
noremap <leader>c "+y
noremap <leader>v "+p

noremap <leader>p "0p

noremap <leader>w :w<cr>
