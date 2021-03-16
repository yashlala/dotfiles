"""""""""""""""""""
" Config
"""""""""""""""""""
set lazyredraw

set ignorecase
set smartcase
set nohlsearch
set nojoinspaces
set gdefault

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
set confirm
set autoindent
set undofile
filetype plugin indent on
syntax on


"""""""""""""""""""
" Plugins
"""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')

" loaded plugins
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/seoul256.vim'

Plug 'dhruvasagar/vim-table-mode'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'easymotion/vim-easymotion'
Plug 'darrikonn/vim-gofmt', { 'do': ':GoUpdateBinaries' }
Plug 'psf/black', { 'branch': 'stable' }

Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'tpope/vim-repeat'

call plug#end()


"""""""""""""""""""
" Plugin Settings
"""""""""""""""""""
colorscheme seoul256
let g:seoul256_srgb = 1

let g:lightline = {'colorscheme': 'seoul256'}
set noshowmode

let g:EasyMotion_smartcase = 1

let g:ale_enabled = 0
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
let g:ale_lint_delay = 500
let g:ale_fix_on_save = 1

"""""""""""""""""""
" Autocommands
"""""""""""""""""""

" return to last edit position when opening files
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

autocmd BufNewFile,BufRead neomutt-* set filetype=mail


"""""""""""""""""""
" Keybindings
"""""""""""""""""""
noremap Y y$
noremap ; :
noremap : q:
noremap ' `
noremap <bslash> "
noremap - 0

nnoremap ` ~
nnoremap <cr> o<esc>
nnoremap <bar> K
nnoremap K kJ
nnoremap Q @@
nnoremap <silent> S :keepp s/\s*\%#\s*/\r/e <bar> norm! ==<CR>
nnoremap U <c-r>
nnoremap <c-r> U
nnoremap v V

noremap <bs> <c-u>
noremap <up> <c-u>
noremap <tab> <c-d>
noremap <down> <c-d>
noremap _ <c-y>
noremap + <c-e>

map <space> <Plug>(easymotion-prefix)
map f <Plug>(easymotion-fl)
map F <Plug>(easymotion-Fl)
map t <Plug>(easymotion-tl)
map T <Plug>(easymotion-Tl)

" swap 'uncountably high' numbers with their symbols,
" with some tweaks, of course.
noremap 4 $
noremap $ 4
noremap 5 %
noremap % 5
noremap 6 ^
noremap ^ 6
noremap <silent> 7 :&&<cr>
noremap & 7
noremap 8 @
noremap * 8
noremap 9 (
noremap ( 9
noremap 0 )
noremap ) 0

map ga <Plug>(EasyAlign)
nnoremap gs :%s/

" leader keybinds
let mapleader = ','
let g:mapleader = ','

" jao
noremap <silent> <leader>j :ALEGoToDefinition<cr>
" kya
noremap <silent> <leader>k :ALEHover<cr>
" fix
noremap <silent> <leader>f :ALEFix<cr>

noremap <silent> <leader>p "0p
noremap <silent> <leader>P "0P

nnoremap <leader>d :r !date --iso-8601<cr>
nnoremap <silent> <leader>q :q!<cr>
nnoremap <silent> <leader>e :e!<cr>

nnoremap <silent> <leader>g :G<cr>
nnoremap <silent> <leader>m :Goyo<cr>
