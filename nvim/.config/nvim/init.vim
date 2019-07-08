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
noremap : K
noremap K kJ
noremap ` ~
noremap U <c-r>
nnoremap <cr> o<esc>
noremap Q @@
noremap q; q:

" learn to use tabs and buffers so you can use all these free keys
noremap <bs> 
noremap <tab> 
noremap <up> 
noremap <down> 
noremap <left> g;
noremap <right> g,

" plugin bindings
map <space> <Plug>(easymotion-prefix)
map f <Plug>(easymotion-fl)
map F <Plug>(easymotion-Fl)
map t <Plug>(easymotion-tl)
map T <Plug>(easymotion-Tl)

noremap gs y:%s//g<left><left>
noremap ga <Plug>(EasyAlign)

" swap 'uncountably high' numbers with their symbols
noremap 4 $
noremap 5 %
noremap 6 ^
noremap 7 &
noremap 8 *
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
