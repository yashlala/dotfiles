-- Adapted from TJDevries' great video.
-- Take another look through it to resolve the todos.

local luasnip = require('luasnip')
local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
  mapping = cmp.mapping.preset.insert{
    -- Ask the world for completions
    ['<c-y>'] = cmp.mapping.complete(),
    -- Cancel completion.
    ['<c-e>'] = cmp.mapping.close(),
    -- Accept the current completion
    ['<c-space>'] = cmp.mapping(function()
      -- TODO: This may be inteferring with luasnip. 
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif cmp.visible() then
        cmp.confirm { behavior = cmp.ConfirmBehavior.insert, select = true }
      end
    end, { 'i', 'v', 'n', 'c' }),
  },

  sources = {
    { name = 'nvim_lsp_signature_help' }, -- LSP function signatures
    { name = 'nvim_lsp' }, -- Regular LSP suggestions
    -- { name = 'luasnip' }, -- TODO Tweak
    { name = 'nvim_lua' }, -- nvim API LSP suggestions
    { name = 'buffer' }, -- Similar words in the current buffer
    { name = 'path' }, -- Paths in the local filesystem
  },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },

  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[lsp]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
      }
    }
  },

  experimental = {
    native_menu = false, -- Use the new, fancy menu.
    ghost_text = true,
  }
})

-- Completion in command mode as well
require'cmp'.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline{},
  sources = {
    { name = 'cmdline' }
  }
})

-- Load all snippets provided by `friendly-snippets`.
require("luasnip.loaders.from_vscode").lazy_load()

-- TODO: Add in colorbuddy highlight groups.
