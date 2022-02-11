-- Adapted from TJDevries' great video.
-- Take another look through it to resolve the todos.

local luasnip = require('luasnip')
local cmp = require('cmp')
local lspkind = require('lspkind')

-- TODO: We can fix this using the luasnip API documentation.
cmp.setup({
  -- TODO: Add more bindings! Control key is easy now.
  -- Ideally we would keep tapping control space and it would work
  mapping = {
    -- ['<Tab>'] = cmp.mapping(function()
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expand_or_jumpable() then
    --     return t("<Plug>luasnip-expand-or-jump")
    --   elseif check_back_space() then
    --     return t "<Tab>"
    --   else
    --   end
    -- end, { 'i', 's' }),

    -- Ask the world for completions
    ['<c-y>'] = cmp.mapping.complete(),
    -- Cancel completion.
    ['<c-e>'] = cmp.mapping.close(),
    -- Accept the current completion
    ['<c-space>'] = cmp.mapping(function()
      if luasnip.expand_or_jumpable() then
        print('luasnip option')
        luasnip.expand_or_jump()
      elseif cmp.visible() then
        print('cmp option')
        cmp.confirm { behavior = cmp.ConfirmBehavior.insert, select = true }
      end
    end, { 'i', 'v', 'n', 'c' }),
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lua' }, -- automatically runs only for lua
    { name = 'buffer', keyword_length = 5 },
    { name = 'path', keyword_length = 5 }, -- TODO: kw_len not working
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
    -- Use the new, fancy menu.
    native_menu = false,
    ghost_text = true,
  }
})

-- Completion in command mode as well
require'cmp'.setup.cmdline(':', {
  sources = {
    { name = 'cmdline' }
  }
})

-- Load all snippets provided by `friendly-snippets`.
require("luasnip.loaders.from_vscode").lazy_load()

-- TODO: Add in colorbuddy highlight groups.
