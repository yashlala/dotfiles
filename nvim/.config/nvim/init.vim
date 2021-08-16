lua <<EOF

--[[
Plugins
--]]

-- Install packer if needed.
local packer_install_path = (vim.fn.stdpath('data')
  .. '/site/pack/packer/start/packer.nvim')
if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim '
  .. packer_install_path)
end

-- Re-compile packer after any edits to our config file.
vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
    autocmd BufWritePost init.vim PackerCompile
  augroup end
]], false)

-- Load plugins.
local use = require('packer').use
require('packer').startup(function()
  -- Package manager.
  use 'wbthomason/packer.nvim' 
  -- Fancier statusline.
  use 'itchyny/lightline.vim'
  -- Buffer list for statusline.
  use 'mengelbrecht/lightline-bufferline'
  -- Indentation guides.
  use 'lukas-reineke/indent-blankline.nvim'
  -- Colorscheme. 
  use 'junegunn/seoul256.vim' 

  -- Automatic table alignment.
  use 'junegunn/vim-easy-align'
  -- Surround vim motions. 
  use 'tpope/vim-surround' 
  -- "gc" keybinding to comment visual regions/lines.
  use 'tpope/vim-commentary'
  -- Unix commands. 
  use 'tpope/vim-eunuch' 
 -- Automatically match file format/indentation.
  use 'tpope/vim-sleuth'

  -- Git commands + Status page.
  use 'tpope/vim-fugitive'
  -- Git related info in signs column and popups.
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -- EasyMotion-style text movements.
  use { 'phaazon/hop.nvim', as = 'hop' }

  -- Collection of configurations for built-in LSP client
  use 'neovim/nvim-lspconfig'
  -- TODO: Enable Treesitter functionality. Has to be done explicitly. 
  -- Highlighting, editing, etc. using incremental parsing. 
  use 'nvim-treesitter/nvim-treesitter'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin. TODO: broken. 

  -- Global Menu and Fuzzy Finder. 
  use { 'nvim-telescope/telescope.nvim', requires = {
    { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
  }
  use { 'nvim-telescope/telescope-fzy-native.nvim', requires = {
    { 'nvim-telescope/telescope.nvim' } } 
  }
  -- Autocompletion plugin
  use 'hrsh7th/nvim-compe'

  -- Allow plugins to use the `.` key (if they support it). 
  use 'tpope/vim-repeat'
end)


--[[
Other Configuration
--]]

-- Load colorscheme *before* other plugins are set up. 
vim.api.nvim_exec('colorscheme seoul256', false)
vim.g.seoul256_srgb = 1

-- Vanilla Vim Options

vim.o.lazyredraw = true
vim.o.undofile = true
vim.o.hidden = true
vim.o.gdefault = true
vim.o.ignorecase = true
vim.o.hlsearch = false
vim.o.joinspaces = false
vim.o.smartcase = true
-- TODO: does using the 'unnamedplus' clipboard break everything? 
-- vim.o.clipboard = 'unnamedplus'
vim.o.foldenable = false
vim.o.foldlevel = 1
vim.o.foldmethod = 'syntax'
vim.o.foldnestmax = 1
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.mouse = 'a'
vim.o.modeline = true
vim.o.confirm = true
vim.o.autoindent = true

-- "Simple" Keybinds

vim.api.nvim_set_keymap('n', ' ', '<noop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('', 'Y', 'y$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('', ':', 'q:', { noremap = true, silent = true })
-- TODO: Move all the vim components of the binds up here. 


-- "Simple" Plugins

require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })

vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_filetype_exclude = { 'markdown', 'text', 'asciidoc' }

-- Git Plugin Setup

require('gitsigns').setup {
  signs = {
    add = {
      hl = 'GitSignsAdd',
      text = '│', numhl='GitSignsAddNr',
      linehl='GitSignsAddLn'
    },
    change = {
      hl = 'GitSignsChange',
      text = '│',
      numhl='GitSignsChangeNr',
      linehl='GitSignsChangeLn'
    },
    delete = {
      hl = 'GitSignsDelete',
      text = '_', numhl='GitSignsDeleteNr',
      linehl='GitSignsDeleteLn'
    },
    topdelete = {
      hl = 'GitSignsDelete',
      text = '‾',
      numhl='GitSignsDeleteNr',
      linehl='GitSignsDeleteLn'},
    changedelete = {
      hl = 'GitSignsChange',
      text = '~',
      numhl='GitSignsChangeNr',
      linehl='GitSignsChangeLn'},
  },
  numhl = false,
  linehl = false,
  keymaps = {
    -- Default keymap options
    noremap = true,
    ['n ]g'] = {
      expr = true,
      "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"
    },
    ['n [g'] = {
      expr = true,
      "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"       
    },
    ['n <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>gu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>gR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>gp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    ['n <leader>gtb'] = '<cmd>lua require"gitsigns".toggle_current_line_blame()<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
  watch_index = {
    interval = 1000,
    follow_files = true
  },
  current_line_blame = false,
  current_line_blame_delay = 1000,
  current_line_blame_position = 'eol',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  word_diff = false,
  use_decoration_api = true,
  use_internal_diff = true,  -- If luajit is present
}


-- Global Menu + Fuzzy Finder Configuration

require('telescope').load_extension('fzy_native')

vim.api.nvim_set_keymap('n', '<leader>fb',
  "<cmd>lua require('telescope.builtin').file_browser({})<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap('n', '<leader>ff',
  "<cmd>lua require('telescope.builtin').find_files({})<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap('n', '<leader>fg', 
  "<cmd>lua require('telescope.builtin').grep_string({})<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap('n', '<leader>fp',
  "<cmd>lua require('telescope.builtin').git_files({})<cr>",
  { noremap = true, silent = true }
)


-- Autocomplete + LSP Plugin Setup

-- Set up LSP Configurations. 
require('lspconfig').pyright.setup({})
require('lspconfig').ccls.setup({})
require('lspconfig').bashls.setup({})
require('lspconfig').ccls.setup({})
require('lspconfig').texlab.setup({})
require('lspconfig').dockerls.setup({})
require('lspconfig').gopls.setup({})
require('lspconfig').jedi_language_server.setup{}

-- Setup `compe`. 
vim.o.completeopt = "menuone,noselect"
require('compe').setup({
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'always';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    -- the border option is the same as `|help nvim_open_win|`
    border = { '', '' ,'', ' ', '', '', '', ' ' }, 
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = false;
    ultisnips = false;
    luasnip = true;
  };
})

-- Implement "Completion-Toggle" keybinds. 
require('completion-toggle')
vim.api.nvim_set_keymap('n', '<leader>ct', "<cmd>CompeToggle<cr>", { noremap = true })


--[[
BEGIN: THINGS I DON'T UNDERSTAND
--]]

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['luasnip#expand_or_jumpable']() == 1 then
    -- TODO: fix this condition, and this thing in the middle. It used to look
    -- like this: 
    -- elseif vim.fn['vsnip#available'](1) == 1 then
    --  return t "<Plug>(vsnip-expand-or-jump)"
    -- TODO: adapt it to LuaSnip! The current code is a guess, and doesn't work right. 
    return t "<Plug>(luasnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

--[[
END (ish): THINGS I DON'T UNDERSTAND
--]]

EOF

inoremap <silent><expr> <CR>      compe#confirm('<CR>')

filetype plugin indent on
syntax on


"""""""""""""""""""
" Plugins
"""""""""""""""""""


"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }


"""""""""""""""""""
" Plugin Settings
"""""""""""""""""""
colorscheme seoul256
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ ['buffers'] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ],  [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }
let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#unnamed = '[No Name]'

set noshowmode

let g:go_doc_keywordprg_enabled = 0 " disable K keybind.

"""""""""""""""""""
" Autocommands
"""""""""""""""""""

" return to last edit position when opening files
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

autocmd BufNewFile,BufRead neomutt-* set filetype=mail

" The bottom status line doesn't update very often, so the buffer listing can
" become stale. Avoid this by throwing in a few autocommands (we have a
" function later in this file that mitigates this problem as well)
autocmd BufEnter,BufLeave,BufWritePost,BufHidden,BufWinEnter,BufWinLeave,CmdlineEnter,InsertEnter *
  \ call lightline#update()

"""""""""""""""""""
" Keybindings
"""""""""""""""""""
noremap ' `
noremap <bslash> "
noremap - 0

nnoremap ` ~
nnoremap <cr> o<esc>
nnoremap <bar> K
nnoremap K kJ
nnoremap Q @@
nnoremap <silent> S <cmd>keepp s/\s*\%#\s*/\r/e <bar> norm! ==<CR>
nnoremap U <c-r>
nnoremap <c-r> U
nnoremap v V

noremap _ <c-y>
noremap + <c-e>

nnoremap <silent> <C-N> <cmd>bnext<CR>
nnoremap <silent> <C-P> <cmd>bprev<CR>

" swap 'uncountably high' numbers with their symbols,
" with some tweaks, of course.
noremap 4 $
noremap $ 4
noremap 5 %
noremap % 5
noremap 6 ^
noremap ^ 6
noremap <silent> 7 <cmd>&&<cr>
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
nnoremap <space> <nop>
let mapleader = ' '
let g:mapleader = ' '


noremap <silent> <leader>p "0p
noremap <silent> <leader>P "0P

function! DeleteBufferAndUpdateLightline()
  exe 'bdelete'
  call lightline#update()
endfunction
nnoremap <silent> <leader>q <cmd>q<cr>
nnoremap <silent> <leader>d <cmd>call DeleteBufferAndUpdateLightline()<cr>
nnoremap <silent> <leader>e <cmd>e<cr>

" matches the other git commands. 
nnoremap <silent> <leader>gg <cmd>G<cr> 

nnoremap <silent> <leader>m <cmd>Goyo<cr>
nnoremap <silent> <leader><leader> <cmd>Telescope<cr>
nnoremap , <cmd>HopChar1<cr>

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)
