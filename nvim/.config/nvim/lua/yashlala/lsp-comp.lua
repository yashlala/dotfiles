local M = {}

local function setup_cmp()
  local luasnip = require('luasnip')
  local cmp = require('cmp')
  local lspkind = require('lspkind')

  vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

  cmp.setup({
    mapping = cmp.mapping.preset.insert{
      -- Ask the world for completions
      ['<c-y>'] = cmp.mapping.complete({}),
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
  -- TODO: Handle '%:h' correctly via https://github.com/hrsh7th/cmp-cmdline/issues/33
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline{},
    sources = {
      { name = 'cmdline' }
    }
  })

  -- Load all snippets provided by `friendly-snippets`.
  require('luasnip.loaders.from_vscode').lazy_load()
end

local function setup_lsp(capabilities)
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

  lspconfig.clangd.setup({
    on_attach = function(_, bufnr)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gH',
      '<cmd>ClangdSwitchSourceHeader<cr>', { noremap = true })
    end
  })

  local lua_runtime_path = vim.split(package.path, ';')
  table.insert(lua_runtime_path, 'lua/?.lua')
  table.insert(lua_runtime_path, 'lua/?/init.lua')
  lspconfig.sumneko_lua.setup {
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

  vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
  })
end

M.setup = function()
  setup_cmp()
  setup_lsp(require('cmp_nvim_lsp').default_capabilities())
end

return M
