vim.api.nvim_command([[
setlocal formatoptions+=tcrn1 formatoptions-=o
setlocal textwidth=79
let b:ale_warn_about_trailing_whitespace = 0
]])
