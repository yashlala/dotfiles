-- Vanilla Vim Options

vim.o.autochdir = true
vim.o.autoindent = true
vim.o.breakindent = true
vim.o.confirm = true
vim.o.foldenable = false
vim.o.foldlevel = 1
vim.o.foldmethod = 'syntax'
vim.o.foldnestmax = 1
vim.o.gdefault = true
vim.o.hidden = true
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.joinspaces = false
vim.o.lazyredraw = true
vim.o.linebreak = true
vim.o.modeline = true
vim.o.mouse = 'a'
vim.o.scrollback = 1024
vim.o.showmode = false
vim.o.smartcase = true
vim.o.undofile = true
vim.o.wrap = true
-- Swap digits and special characters. We need to do this in `langmap` (as
-- opposed to regular bindings) because Vim isn't able to map all of its modes.
-- map them all (eg: operator-pending for some reason doesn't remap di
vim.o.langremap = false
vim.o.langmap = '1!,!1,2@,@2,3#,#3,$4,4$,5%,%5,6^,^6,7&,&7,8*,*8,9(,(9,0),)0'


-- "Straightforward" Keymaps (there are more in the plugin setup funcs)

-- Vanilla Remaps
vim.api.nvim_set_keymap('n', ' ', '<nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '

vim.api.nvim_set_keymap('', 'Y', 'y$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('', ':', 'q:', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', "'", '`', { noremap = true })
vim.api.nvim_set_keymap('', '\\', '"', { noremap = true })
vim.api.nvim_set_keymap('', '`', '~', { noremap = true })
vim.api.nvim_set_keymap('', '-', '0', { noremap = true })
vim.api.nvim_set_keymap('', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('', ':', 'q:', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<cr>', ':put _<cr>',
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<bar>', 'K', { noremap = true })
vim.api.nvim_set_keymap('n', 'K', 'kJ', { noremap = true })
vim.api.nvim_set_keymap('n', 'U', '<c-r>', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-r>', 'U', { noremap = true })
vim.api.nvim_set_keymap('n', 'v', 'V', { noremap = true })
vim.api.nvim_set_keymap( 'n', 'S',
    [[<cmd>keepp s/\\s*\%#\\s*/\\r/e <bar> norm! ==<CR>]],
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '&', '<cmd>&&<cr>',
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '_', '<c-y>', { noremap = true })
vim.api.nvim_set_keymap('', '+', '<c-e>', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-n>', '<cmd>bnext<cr>',
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-p>', '<cmd>bprev<cr>',
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gs', ':%s/', { noremap = true })
vim.api.nvim_set_keymap('', 'ga', '<Plug>(EasyAlign)', { noremap = false })
-- Simple Leader Keybinds
vim.api.nvim_set_keymap('', '<leader>p', '"0p',
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<leader>P', '"0P',
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d',
    '<cmd>call DeleteBufferAndUpdateLightline()<cr>',
    { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>G<cr>', { noremap = false })
-- Terminal Mode Keybindings
vim.api.nvim_set_keymap('t', '<c-\\>', '<c-\\><c-n>', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-\\>', '<nop>', { noremap = true })
vim.api.nvim_set_keymap('i', '<c-\\>', '<esc>', { noremap = true })
-- EasyMotion Keybindings
vim.api.nvim_set_keymap('', 'f', '<nop>', { noremap = true })
vim.api.nvim_set_keymap('', 'f', '<Plug>(easymotion-f)', { noremap = false })
vim.api.nvim_set_keymap('', 'F', '<Plug>(easymotion-F)', { noremap = false })
vim.api.nvim_set_keymap('', 't', '<Plug>(easymotion-t)', { noremap = false })
vim.api.nvim_set_keymap('', 'T', '<Plug>(easymotion-T)', { noremap = false })
vim.api.nvim_set_keymap('', 's', '<Plug>(easymotion-lineanywhere)',
    { noremap = false })
vim.api.nvim_set_keymap('', '<leader>j', '<Plug>(easymotion-j)',
    { noremap = false })
vim.api.nvim_set_keymap('', '<leader>k', '<Plug>(easymotion-k)',
    { noremap = false })
-- Diary Keybinds
vim.api.nvim_set_keymap('n', '<leader>ww', '<Plug>VimwikiMakeDiaryNote',
    { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>wi', '<cmd>DiaryIndex<cr>',
    { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>wt', '<Plug>VimwikiMakeTodayDiaryNote',
    { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>wy',
    '<Plug>VimwikiMakeYesterdayDiaryNote', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>w<leader>w', '<Plug>VimwikiIndex',
    { noremap = false })
-- Quick Buffer Switching Keybindings
vim.api.nvim_set_keymap('n', '<leader>!',
    '<Plug>lightline#bufferline#go(1)', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>@',
    '<Plug>lightline#bufferline#go(2)', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>#',
    '<Plug>lightline#bufferline#go(3)', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>$',
    '<Plug>lightline#bufferline#go(4)', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>%',
    '<Plug>lightline#bufferline#go(5)', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>^',
    '<Plug>lightline#bufferline#go(6)', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>&',
    '<Plug>lightline#bufferline#go(7)', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>*',
    '<Plug>lightline#bufferline#go(8)', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>(',
    '<Plug>lightline#bufferline#go(9)', { noremap = false })

-- Helper functions used in keybinds above.

vim.api.nvim_exec([[
  function! DeleteBufferAndUpdateLightline()
    exe 'bdelete'
    call lightline#update()
  endfunction
]], false)
--  Visit the diary index with :Diary. It'll regenerate
-- every time we visit it (updates itself with new links).
vim.api.nvim_exec([[
command! DiaryIndex VimwikiDiaryIndex
augroup vimwikigroup
    autocmd!
    " automatically update links on read diary
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end
]], false)


-- Plugins

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
  -- Date increments and decrements w/ <c-a> and <c-x>
  use 'tpope/vim-speeddating' 
  -- Unix commands. 
  use 'tpope/vim-eunuch' 
 -- Automatically match file format/indentation.
  use 'tpope/vim-sleuth'
  -- Vim motions that don't require counts. 
  use 'easymotion/vim-easymotion'

  -- Diary + Wiki
  use 'vimwiki/vimwiki'

  -- Git commands + Status page.
  use 'tpope/vim-fugitive'
  -- Git related info in signs column and popups.
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -- Remove whitespace at the end of modified lines when lives are saved. 
  use 'axelf4/vim-strip-trailing-whitespace'

  -- Collection of configurations for built-in LSP client
  use 'neovim/nvim-lspconfig'
  use 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'

  -- TODO: Enable Treesitter functionality. Has to be done explicitly. 
  -- Highlighting, editing, etc. using incremental parsing. 
  -- use 'nvim-treesitter/nvim-treesitter'
  -- use 'L3MON4D3/LuaSnip' -- Snippets plugin. TODO: broken.

  -- Global Menu and Fuzzy Finder. 
  use { 'nvim-telescope/telescope.nvim', requires = {
    { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
  }
  use { 'nvim-telescope/telescope-fzy-native.nvim', requires = {
    { 'nvim-telescope/telescope.nvim' } } 
  }
  -- Automatically `cd` to project root. Integrates with Telescope. 
  -- Use this to quickly return to old projects (as opposed to searching *in*
  -- a project, which we do with the regular telescope builtins. 
  use "ahmedkhalf/project.nvim"

  -- Autocompletion plugin
  -- use 'hrsh7th/nvim-compe'

  -- Allow plugins to use the `.` key (if they support it). 
  use 'tpope/vim-repeat'
end)


--[[
Kinkier Configuration
--]]

-- Load colorscheme *before* other plugins are set up.
vim.api.nvim_exec('colorscheme seoul256', false)
vim.g.seoul256_srgb = 1

vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_filetype_exclude = { 'markdown', 'text', 'asciidoc' }

vim.api.nvim_set_var('lightline#bufferline#show_number', 2)
vim.api.nvim_set_var('lightline#bufferline#unnamed', '[No Name]')
vim.api.nvim_exec([[
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ ['buffers'] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ],
      \     [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_expand': { 'buffers': 'lightline#bufferline#buffers' },
      \ 'component_type': { 'buffers': 'tabsel' } }
]], false)

vim.g.go_doc_keywordprg_enabled = 0 -- disable K keybind.

vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_smartcase = 1

require('project_nvim').setup({ manual_mode = true })
require('telescope').setup {}
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('projects')

vim.api.nvim_set_keymap('n', '<leader>b',
  "<cmd>lua require('telescope.builtin').buffers({})<cr>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff',
  "<cmd>lua require('telescope.builtin').find_files({})<cr>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg',
  "<cmd>lua require('telescope.builtin').grep_string({})<cr>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fp',
  "<cmd>lua require('telescope.builtin').git_files({})<cr>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fo',
  "<cmd>lua require('telescope.builtin').oldfiles({})<cr>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fP',
  "<cmd>Telescope projects<cr>", { noremap = true, silent = true })

-- Git Plugin Setup

require('gitsigns').setup {
  keymaps = {
    -- Default keymap options
    noremap = true,
    ['n ]g'] = { expr = true,
      "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"
    },
    ['n [g'] = { expr = true,
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
    ['n <leader>tgb'] = '<cmd>lua require"gitsigns".toggle_current_line_blame()<CR>',
    -- Text objects
    ['o ic'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ic'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
  current_line_blame_opts = { virt_text_pos = 'eol', delay = 500 },
  diff_opts = { internal = true },
}


-- Autocomplete + LSP Plugin Setup

-- Set up LSP Configurations.
--[[
require('lspconfig').pyright.setup({})
require('lspconfig').ccls.setup({})
require('lspconfig').bashls.setup({})
require('lspconfig').texlab.setup({})
require('lspconfig').dockerls.setup({})
require('lspconfig').gopls.setup({})
require('lspconfig').jedi_language_server.setup{}
-- require('lspconfig').jdtls.setup{}
--]]

--[[
-- Setup `compe`.
vim.o.completeopt = "menuone,noselect"
require('compe').setup({
  enabled = true;
  autocomplete = false;
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
    orgmode = true;
    vsnip = false;
    ultisnips = false;
    luasnip = true;
  };
})

-- Implement "Completion-Toggle" keybinds.
require('completion-toggle')
vim.api.nvim_set_keymap('n', '<leader>tc', "<cmd>CompeToggle<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', '<c-space>', "<cmd>CompeToggle<cr>", { noremap = true })
vim.api.nvim_set_keymap('i', '<c-space>', "<cmd>CompeToggle<cr>", { noremap = true })
--]]


--[[
BEGIN: THINGS I DON'T UNDERSTAND
--]]

--[[
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
--]]

--[[
END (ish): THINGS I DON'T UNDERSTAND
--]]


vim.api.nvim_exec([[
  filetype plugin indent on
  syntax on
]], false)



--[[
Autocommands
--]]

-- return to last edit position when opening files
vim.api.nvim_exec([[
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
]], false)

vim.api.nvim_exec([[
autocmd BufNewFile,BufRead neomutt-* set filetype=mail
]], false)

-- Close netrw buffers (we can't do this by default, for some reason).
vim.api.nvim_exec("autocmd Filetype netrw setl bufhidden=delete", false)

-- Enter terminal mode as soon as we enter a terminal buffer.
vim.api.nvim_exec("autocmd TermOpen * startinsert", false)

-- The bottom status line doesn't update very often, so the buffer listing can
-- become stale. Avoid this by throwing in a few autocommands (we have a
-- function later in this file that mitigates this problem as well)
vim.api.nvim_exec([[
autocmd BufEnter,BufLeave,BufWritePost,BufHidden,BufWinEnter,BufWinLeave,CmdlineEnter,InsertEnter *
  \ call lightline#update()
]], false)

