" Options

set confirm
set gdefault
set notimeout

set autoindent
set smartindent

set ignorecase
set smartcase

set foldenable
set foldlevelstart=99

set wrap
set breakindent
set linebreak

set belloff=all
set undofile
set updatetime=3000

set lazyredraw
set hlsearch

set pumheight=6
set modeline
set noshowmode

set noequalalways
set splitright
set nosplitbelow

set cpoptions-=_


" Mappings
noremap <leader> <nop>
noremap ', `
noremap ` ~
noremap - 0

nnoremap <c-l> <cmd>nohlsearch|diffupdate|normal! <c-l><cr>
nnoremap <c-r> <cmd>nohlsearch|diffupdate|normal! <c-l><cr>

noremap ; :
nnoremap : q:
vnoremap : q:

nnoremap @; @:
nnoremap K kJ
nnoremap gK kgJ
nnoremap U <c-r>
nnoremap V v
nnoremap v V
vnoremap V v
vnoremap v V
onoremap V v
onoremap v V

vnoremap <c-g> g<c-g>
" keep cursor at selection end
vnoremap y ygv<esc> 

nnoremap gl :%
nnoremap gs :%s/
nnoremap gG :%g/
nnoremap g/ :silent grep! 
nnoremap g? :silent grep!  %<left><left>
nnoremap gh <cmd>cd %:h<cr>

nnoremap <c-]> g<c-]>
nnoremap g<c-]> <c-]>
nnoremap g<c-o> g;
nnoremap g<c-i> g,

nnoremap <leader>n, "_
nnoremap <leader><c-g> 1<c-g>
