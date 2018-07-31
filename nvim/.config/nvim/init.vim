"""""""""""""""""""
" Config
"""""""""""""""""""
set lazyredraw
set noswapfile

set number relativenumber
set smartindent
set ignorecase
set smartcase
set nohlsearch

set wrap
set linebreak
set breakindent
let &showbreak = '↳ '

set modeline
filetype plugin indent on
syntax on

"""""""""""""""""""
" Plugins
"""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')

" colorschemes
"Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'

" functional
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary'
"Plug 'easymotion/vim-easymotion'
"Plug 'tpope/vim-repeat'

call plug#end()

"""""""""""""""""""
" Plugin Settings
"""""""""""""""""""
colorscheme seoul256
let g:seoul256_srgb = 1

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

noremap <leader>P "0p

noremap <leader>w :w<cr>
noremap <leader>qq :q!<cr>
