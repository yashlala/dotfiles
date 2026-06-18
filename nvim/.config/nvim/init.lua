-- `init.lua`

-- TODO:
--
-- set nvim-cmp so it'll replace the ends of words. and so it'll only complete
-- till the ambiguity instead of for the longest match (wtf?).
--
-- set highlighting for just a "Q:" in vimwiki files so we can do topical
-- trees

-- Set global variables and lua functions early in our config, so all modules
-- will see them.
vim.g.mapleader = ' '
require('yashlala.globals').setup()

-- Source basic options and keymaps first.
-- All more complicated things are in the `after/plugin` dir.
require('yashlala.options').setup()
require('yashlala.mappings').setup()

-- Run build steps for plugins that need compilation, on install or update.
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind, path = ev.data.spec.name, ev.data.kind, ev.data.path
    if kind ~= 'install' and kind ~= 'update' then return end
    if name == 'telescope-fzf-native.nvim' then
      vim.system({ 'make' }, { cwd = path })
    elseif name == 'LuaSnip' then
      vim.system({ 'make', 'install_jsregexp' }, { cwd = path })
    end
  end,
})

-- Source our plugins
-- NOTE: LuaSnip uses select-mode to highlight fields prior to replacing
-- them. Eg ([X] := "X is highlighted, visually):
--
--    for (int [varNameHere]; ...)
--
-- Mappings defined with `v(nore)map` apply to visual _and_ select modes. So
-- `vnoremap s <Plug>(SubversiveSubstitute)` will make it impossible to type
-- variable names starting with "s". Always use `xmap` instead of `vmap`
-- while we have LuaSnip installed.
vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/tpope/vim-sleuth',
  'https://github.com/thirtythreeforty/lessspace.vim',
  'https://github.com/smoka7/hop.nvim',
  'https://github.com/junegunn/vim-easy-align',
  'https://github.com/tpope/vim-surround',
  'https://github.com/wellle/targets.vim',
  'https://github.com/svermeulen/vim-subversive',
  'https://github.com/numToStr/Comment.nvim',
  'https://github.com/tpope/vim-speeddating',
  'https://github.com/tpope/vim-eunuch',
  'https://github.com/tpope/vim-rhubarb',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/kevinhwang91/nvim-bqf',
  'https://github.com/yashlala/marker.nvim',
  'https://github.com/ThePrimeagen/harpoon',
  'https://github.com/akinsho/toggleterm.nvim',
  'https://github.com/yashlala/vim-sayonara',
  'https://github.com/onsails/lspkind-nvim',
  { src = 'https://github.com/chipsenkbeil/distant.nvim', version = 'v0.2' },
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/hrsh7th/cmp-cmdline',
  'https://github.com/hrsh7th/cmp-nvim-lua',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help',
  'https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol',
  'https://github.com/williamboman/mason.nvim',
  'https://github.com/williamboman/mason-lspconfig.nvim',
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/lspcontainers/lspcontainers.nvim',
  'https://github.com/zbirenbaum/copilot.lua',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/saadparwaiz1/cmp_luasnip',
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/aznhe21/actions-preview.nvim',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/vimwiki/vimwiki',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  -- popup.nvim removed: its API was merged into neovim core
  'https://github.com/nvim-telescope/telescope-file-browser.nvim',
  'https://github.com/DrKJeff16/project.nvim',
  'https://github.com/stevearc/dressing.nvim',
  'https://github.com/AckslD/nvim-neoclip.lua',
  'https://github.com/tpope/vim-repeat',
})

require('marker').setup()
require('dressing').setup()

require('yashlala.lsp-comp').setup()
require('yashlala.autocmds').setup()

-- TODO: Highlight the signs column like we do in gitsigns.
vim.api.nvim_command('highlight WinSeparator guibg=None')

-- Disable legacy language providers (doesn't affect remote plugins)
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
