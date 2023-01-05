local M = {}

M.setup = function()
  P = function(v)
    print(vim.inspect(v))
    return v
  end

  RELOAD = function(...)
    return require("plenary.reload").reload_module(...)
  end

  R = function(name)
    RELOAD(name)
    return require(name)
  end

  v = vim
end

return M
