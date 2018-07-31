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

Plug 'junegunn/seoul256.vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
"Plug 'easymotion/vim-easymotion'
"Plug 'tpope/vim-repeat'

call plug#end()

"""""""""""""""""""
" Plugin Settings
"""""""""""""""""""
colorscheme seoul256
let g:seoul256_srgb = 1

"""""""""""""""""""
" Key Rebindings  
"""""""""""""""""""
nnoremap <cr> o<esc>
nnoremap <space> :

"gc is vim-commentary
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let mapleader = ','
let g:mapleader= ','

"""""""""""""""""""
" Leader Commands
"""""""""""""""""""
xmap <leader>a <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)
nnoremap <leader>c gc

nnoremap <leader>g :Goyo<cr>

noremap <leader>y "+y
noremap <leader>p "+p
noremap <leader>P "0p

noremap <leader>w :w<cr>
noremap <leader>qq :q!<cr>
