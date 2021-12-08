-- Adapted from TJDevries' great video. 
-- Take another look through it to resolve the todos. 

local cmp = require("cmp")

local lspkind = require("lspkind")
lspkind.init()

cmp.setup({
  mapping = { 
    -- TODO: Add more bindings! Control key is easy now. 
    -- Ideally we would keep tapping control space and it would work
    -- Ask the world for completions
    ["<c-y>"] = cmp.mapping.complete(), 
    -- Cancel completion. 
    ["<c-e>"] = cmp.mapping.close(), 
    -- Accept the current completion
    ["<c-space>"] = cmp.mapping.confirm { 
      behavior = cmp.ConfirmBehavior.insert, 
      select = true
    }

    -- Control N and Control P already scroll around. 
  },

  sources = { 
    { name = "nvim_lua" }, -- automatically runs only for lua
    { name = "nvim_lsp" }, 
    { name = "path", keyword_length = 5 }, 
    { name = "luasnip" }, 
    -- Don't start suggestions until we've typed in more than a few chars. 
    { name = "buffer", keyword_length = 5 }, 
  },

  snippet = { 
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
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

-- TODO: Add in colorbuddy highlight groups. 
