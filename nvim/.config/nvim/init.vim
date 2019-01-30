"""""""""""""""""""
" Config
"""""""""""""""""""
set lazyredraw

set ignorecase
set smartcase
set nohlsearch
set nojoinspaces

set clipboard=unnamedplus

set foldmethod=syntax
set foldnestmax=1
set nofoldenable
set foldlevel=1

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
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'

Plug 'easymotion/vim-easymotion' 

" registered but not loaded
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

let g:EasyMotion_smartcase = 1

"""""""""""""""""""
" Key Rebindings  
"""""""""""""""""""
noremap Y y$
noremap ; :
noremap U <c-r>
nnoremap <cr> o<esc>^D

" learn to use tabs and buffers so you can use all this free real estate
" the block below is crap
nnoremap <bs> g;
nnoremap <tab> g,
" nnoremap <up> :tabr<cr>
" nnoremap <down> :tabl<cr>
" nnoremap <left> :tabp<cr>
" nnoremap <right> :tabn<cr>

map <space> <Plug>(easymotion-prefix)
map f <Plug>(easymotion-fl)
map F <Plug>(easymotion-Fl)
map t <Plug>(easymotion-tl)
map T <Plug>(easymotion-Tl)

noremap gs y:%s//g<left><left>
noremap ga <Plug>(EasyAlign)

"""""""""""""""""""
" Leader Commands
"""""""""""""""""""
let mapleader = ','
let g:mapleader= ','

nnoremap <leader>g :Goyo<cr>

noremap  <leader>p "0p
noremap  <leader>P "0P

nnoremap  <leader>q :q!<cr>
