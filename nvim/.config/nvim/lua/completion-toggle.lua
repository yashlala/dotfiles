-- ~/.config/nvim/lua/completion.lua

local compe = require('compe')

local M = {}

M._locals = {}

M.toggle = function()
  local bufnr = vim.api.nvim_get_current_buf()
  if M._locals[bufnr] then
    compe.setup(M._locals[bufnr], bufnr)
    M._locals[bufnr] = nil
  else
    M._locals[bufnr] = vim.deepcopy(require('compe.config').get())
    compe.setup({enabled = false}, bufnr)
  end
end

M.setup = function(config, bufnr)
  if bufnr then
    if bufnr == 0 then
      bufnr = vim.api.nvim_get_current_buf()
    end
    if M._locals[bufnr] then
      M._locals[bufnr] = config
      return
    end
  end
  compe.setup(config, bufnr)
end

vim.cmd([[
function! CompeSetup(config, ...) abort
  call luaeval('require"completion-toggle".setup(_A[1], _A[2])', [a:config, get(a:, 1, v:null)])
endfunction
]])

vim.cmd([[command! CompeToggle lua require'completion-toggle'.toggle()]])

return M
