require'lspconfig'.clangd.setup{}

require('lspconfig').bashls.setup({})

require('lspconfig').gopls.setup({})

require('lspconfig').pyright.setup({})

require('lspconfig').jedi_language_server.setup({})

require('lspconfig').texlab.setup({})

local lua_runtime_path = vim.split(package.path, ';')
table.insert(lua_runtime_path, 'lua/?.lua')
table.insert(lua_runtime_path, 'lua/?/init.lua')
require'lspconfig'.sumneko_lua.setup {
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
