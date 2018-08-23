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

" loaded plugins
Plug 'junegunn/seoul256.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
" registered but not loaded
Plug 'easymotion/vim-easymotion' , { 'on': [] }
Plug 'Shougo/deoplete.nvim' , { 'on': [] } 

call plug#end()

"""""""""""""""""""
" Plugin Settings
"""""""""""""""""""
colorscheme seoul256
let g:seoul256_srgb = 1

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ }
set noshowmode

"""""""""""""""""""
" Key Rebindings  
"""""""""""""""""""
nnoremap <cr> o<esc>^D
nnoremap <space> :
nnoremap Y y$

nnoremap gs y:%s//g<left><left>
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" gc = vim-commentary

let mapleader = ','
let g:mapleader= ','

"""""""""""""""""""
" Leader Commands
"""""""""""""""""""
xmap     <leader>a <Plug>(EasyAlign)
nmap     <leader>a <Plug>(EasyAlign)

" gc = vim-commentary
nmap     <leader>c gc

nnoremap <leader>g :Goyo<cr>

noremap  <leader>y "+y
noremap  <leader>p "+p
noremap  <leader>P "0p

noremap  <leader>w :w<cr>
noremap  <leader>qq :q!<cr>

"""""""""""""""""""
" Commands
"""""""""""""""""""

