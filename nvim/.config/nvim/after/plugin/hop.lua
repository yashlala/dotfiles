vim.schedule(function()
  vim.cmd[[
  highlight HopNextKey  guifg=#00dfff gui=bold ctermfg=45 cterm=bold
  highlight HopNextKey1 guifg=#00dfff gui=bold ctermfg=45 cterm=bold
  highlight HopNextKey2 guifg=#00dfff ctermfg=45
  highlight HopUnmatched guifg=#666666 guibg=bg guisp=#666666 ctermfg=242
  highlight link HopCursor Cursor

  augroup HopInitHighlight
    autocmd!
    autocmd ColorScheme * lua require'hop.highlight'.insert_highlights()
  augroup end
  ]]
end)

require('hop').setup({
  keys = 'asdfghjkl;qwertyuiopzxcvbnm',
  create_hl_autocmd = false,
  quit_key = '<esc>',
  char2_fallback_key = '<esc>',
  teasing = false,  -- Don't display annoying error message
  multi_windows = false,
})
