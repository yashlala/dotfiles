local M = {}

local function setup_cmp()
  vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
  })

  local luasnip = require('luasnip')
  local cmp = require('cmp')
  local lspkind = require('lspkind')

  vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

  cmp.setup({
    mapping = cmp.mapping.preset.insert{
      -- Accept the topmost completion immediately.
      ['<c-space>'] = cmp.mapping(function()
        if cmp.visible() then
          cmp.confirm {
            select = true, -- auto select the first entry in the list
            behavior = cmp.ConfirmBehavior.Insert, -- insert text, don't replace
          }
        end
      end, { 'i', 'c' }),

      -- Narrow down ambiguity in the completions
      ['<c-e>'] = cmp.mapping(function()
        if cmp.visible() then
          return cmp.complete_common_string {
            behavior = cmp.ConfirmBehavior.Insert,
          }
        end
      end, { 'i', 'c' }),
    },

    -- TODO: Only enable LSP for coding buffers
    sources = {
      { name = 'nvim_lsp', group_index = 1 }, -- Regular LSP suggestions
      { name = 'nvim_lsp_signature_help', group_index = 1 }, -- LSP function signatures
      { name = 'nvim_lua', group_index = 1 }, -- nvim API LSP suggestions
      { name = 'orgmode', group_index = 2 },
      { name = 'buffer', group_index = 2 }, -- Similar words in the current buffer
      { name = 'path', group_index = 2 }, -- Paths in the local filesystem
    },

    -- This block is copied from TJDevries' config. Don't trust it yet.
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        -- Copied from cmp-under. I don't think I need the plugin for this.
        function(entry1, entry2)
          local _, entry1_under = entry1.completion_item.label:find "^_+"
          local _, entry2_under = entry2.completion_item.label:find "^_+"
          entry1_under = entry1_under or 0
          entry2_under = entry2_under or 0
          if entry1_under > entry2_under then
            return false
          elseif entry1_under < entry2_under then
            return true
          end
        end,
        cmp.config.compare.kind,
      },
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

      -- TODO: change line to ghost_text = true when:
      -- https://github.com/hrsh7th/nvim-cmp/issues/1565
      -- is resolved.
      ghost_text = { enabled = true }
    }
  })

  -- Completion in command mode as well
  -- TODO: Handle '%:h' correctly via https://github.com/hrsh7th/cmp-cmdline/issues/33
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline{},
    sources = {
      { name = 'cmdline' }
    }
  })

  cmp.setup.cmdline('/', {
    sources = cmp.config.sources({ -- priority; "buffer" not used so long as doc symbol is
      { name = 'nvim_lsp_document_symbol' }
    }, {
      { name = 'buffer' }
    })
  })


  -- LuaSnip

  vim.keymap.set('i', '<c-s>', function()
    require'cmp'.complete { config = {
      sources = {{ name = 'luasnip' }}
    }}
  end)
  -- TODO: For some reason, <c-l> is often sent twice (even in non luasnip
  -- contexts. This completely breaks using it for snippet expansions.
  -- Figure out why, and fix the behavior.
  -- TODO: Also, <c-space> from nvim-cmp doesn't work either. It's double-sent
  -- or something. God knows why.
  vim.keymap.set('i', '<c-j>', function()
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    end
  end)
  -- vim.keymap.set('i', '<c-k>', function()
  --   require('luasnip.extras.select_choice')()
  -- end)

  require('yashlala.snippet-list')
end

local function setup_lsp(capabilities)
  -- These must be run _BEFORE_ lspconfig setup!
  -- See :h mason-lspconfig-quickstart.
  require('mason').setup()
  require('mason-lspconfig').setup()

  local lspconfig = require('lspconfig')
  local lsp_defaults = {
    capabilities = capabilities,
  }
  lspconfig.util.default_config = vim.tbl_extend('force',
    lspconfig.util.default_config, lsp_defaults)

  lspconfig.bashls.setup({})
  lspconfig.gopls.setup({})
  lspconfig.pyright.setup({})
  lspconfig.texlab.setup({})
  lspconfig.jedi_language_server.setup({})
  lspconfig.hls.setup({})
  lspconfig.clojure_lsp.setup({})
  lspconfig.rust_analyzer.setup({})

  lspconfig.clangd.setup({
    on_attach = function(_, bufnr)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gH',
      '<cmd>ClangdSwitchSourceHeader<cr>', { noremap = true })
    end
  })

  local lua_runtime_path = vim.split(package.path, ';')
  table.insert(lua_runtime_path, 'lua/?.lua')
  table.insert(lua_runtime_path, 'lua/?/init.lua')
  lspconfig.lua_ls.setup {
    capabilities = capabilities,
    cmd = { '/usr/bin/lua-language-server' },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most
          -- likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = lua_runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          -- Disable annoying error message
          checkThirdParty = false,
        },
        -- Send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = true,
        },
      },
    },
  }

end

M.setup = function()
  setup_cmp()
  setup_lsp(require('cmp_nvim_lsp').default_capabilities())
end

return M
