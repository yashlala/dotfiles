"""""""""""""""""""
" Config
"""""""""""""""""""
set lazyredraw

set ignorecase
set smartcase
set nohlsearch
set nojoinspaces

set clipboard=unnamedplus
set keywordprg=search

set foldmethod=syntax
set foldnestmax=1
set nofoldenable
set foldlevel=1

set wrap
set linebreak
set breakindent
let &showbreak = '↳ '

set modeline
set autoindent
filetype plugin indent on
syntax on

"""""""""""""""""""
" Autocommands
"""""""""""""""""""
" trim trailing whitespace for certain filetypes
autocmd FileType c,cpp,python,sh,bash,zsh,vim,conf
  \ autocmd BufWritePre <buffer> %s/\s\+$//e

" return to last edit position when opening files
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

"""""""""""""""""""
" Plugins
"""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')

" loaded plugins
Plug 'junegunn/seoul256.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'

Plug 'easymotion/vim-easymotion'

call plug#end()

"""""""""""""""""""
" Plugin Settings
"""""""""""""""""""
colorscheme seoul256
let g:seoul256_srgb = 1

let g:lightline = {'colorscheme': 'seoul256'}
set noshowmode

let g:EasyMotion_smartcase = 1

"""""""""""""""""""
" Key Rebindings
"""""""""""""""""""
noremap Y y$
noremap ; :
noremap ' `
noremap \ "

nnoremap V v
nnoremap v V
nnoremap U <c-r>
nnoremap <cr> o<esc>
nnoremap K kJ
nnoremap ` ~
nnoremap Q @@
nnoremap \| K
nnoremap : q:

noremap <bs> <c-u>
noremap <tab> <c-d>
noremap <up> <c-u>
noremap <down> <c-d>
noremap <left> g;
noremap <right> g,

" plugin bindings
map <space> <Plug>(easymotion-prefix)
map f <Plug>(easymotion-fl)
map F <Plug>(easymotion-Fl)
map t <Plug>(easymotion-tl)
map T <Plug>(easymotion-Tl)

noremap gs :%s//g<left><left>
map ga <Plug>(EasyAlign)

" swap 'uncountably high' numbers with their symbols
noremap 4 $
noremap 5 %
noremap 6 ^
noremap 7 :&&<cr>
noremap 8 @
noremap 9 (
noremap 0 )

noremap $ 4
noremap % 5
noremap ^ 6
noremap & 7
noremap * 8
noremap ( 9
noremap ) 0
noremap - 0

"""""""""""""""""""
" Leader Commands
"""""""""""""""""""
let mapleader = ','
let g:mapleader= ','

nnoremap <leader>d :r !date --iso-8601<cr>
nnoremap <leader>m Go<!--<cr>vim: ft=markdown<cr>--><esc>''

nnoremap <leader>g :Goyo<cr>

noremap  <leader>p "0p
noremap  <leader>P "0P

nnoremap  <leader>q :q!<cr>
nnoremap  <leader>e :e!<cr>
