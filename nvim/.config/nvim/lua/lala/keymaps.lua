-- This file contains "vanilla" keymaps for Vim. 

-- The maps here don't really fit into a bigger picture. 
-- If they do, you'll probably find them in a dedicated file instead. 

local M = function() 
  local function map(mode, key, value)
    vim.api.nvim_set_keymap(mode, key, value, { noremap = false })
  end

  local function smap(mode, key, value)
    vim.api.nvim_set_keymap(mode, key, value,
      { noremap = false, silent = true })
  end

  local function noremap(mode, key, value)
    vim.api.nvim_set_keymap(mode, key, value, { noremap = true })
  end

  local function snoremap(mode, key, value)
    vim.api.nvim_set_keymap(mode, key, value, { noremap = true, silent = true })
  end

  snoremap('n', ' ', '<nop>')

  noremap('', ';', ':')
  snoremap('', ':', 'q:')
  noremap('', "'", '`')
  noremap('', '`', '~')
  noremap('', '-', '0')
  noremap('', ';', ':')
  snoremap('', ':', 'q:')

  noremap('n', '<bar>', 'K')
  noremap('n', 'K', 'kJ')
  noremap('n', 'U', '<c-r>')
  noremap('n', '<c-r>', 'U')
  noremap('n', 'v', 'V')

  snoremap('', '&', '<cmd>&&<cr>')
  noremap('', '_', '<c-y>')
  noremap('', '+', '<c-e>')
  snoremap('n', '<c-n>', '<cmd>bnext<cr>')
  snoremap('n', '<c-p>', '<cmd>bprev<cr>')
  noremap('n', 'gs', ':%s/')
  map('', 'ga', '<Plug>(EasyAlign)')

  -- Split a line. TODO: Doesn't seem to work anymore. 
  snoremap( 'n', 'S', [[<cmd>keepp s/\\s*\%#\\s*/\\r/e <bar> norm! ==<CR>]])

  -- Easy moving between windows

  noremap('n', '<m-h>', '<c-w>h')
  noremap('i', '<m-h>', '<esc><c-w>h')
  noremap('n', '<m-j>', '<c-w>j')
  noremap('i', '<m-j>', '<esc><c-w>j')
  noremap('n', '<m-k>', '<c-w>k')
  noremap('i', '<m-k>', '<esc><c-w>k')
  noremap('n', '<m-l>', '<c-w>l')
  noremap('i', '<m-l>', '<esc><c-w>l')

  noremap('n', '<m-s>', '<c-w>s')
  noremap('i', '<m-s>', '<esc><c-w>s')
  noremap('n', '<m-v>', '<c-w>v')
  noremap('i', '<m-v>', '<esc><c-w>v')
  noremap('n', '<m-c>', '<c-w>c')
  noremap('i', '<m-c>', '<esc><c-w>c')

  noremap('t', '<m-h>', '<c-\\><c-n><c-w>h')
  noremap('t', '<m-j>', '<c-\\><c-n><c-w>j')
  noremap('t', '<m-k>', '<c-\\><c-n><c-w>k')
  noremap('t', '<m-l>', '<c-\\><c-n><c-w>l')

  noremap('n', '<m-space>', '<nop>') -- prevent current mode confusion
  noremap('i', '<m-space>', '<esc>') -- just keep mashing, we'll get to normal
  noremap('t', '<m-space>', '<c-\\><c-n>')
  noremap('n', '<c-\\>', '<nop>') 
  noremap('i', '<c-\\>', '<esc>') 
  noremap('t', '<c-\\>', '<c-\\><c-n>')


  -- Simple Leader Keybinds
  snoremap('', '<leader>p', '"0p')
  snoremap('', '<leader>P', '"0P')
  smap('n', '<leader>gg', '<cmd>G<cr>')
  smap('n', '<leader>o', '<cmd>silent !uwin<cr>')

  -- Lightline-Bufferline is very bad at updating its buffer list. 
  -- We compensate by manually updating it when deleting a buffer. 
  -- TODO: Remove the bufferline entirely. Useless...
  vim.api.nvim_command([[
    function! DeleteBufferAndUpdateLightline()
      exe 'bdelete'
      call lightline#update()
    endfunction
  ]])
  smap('n', '<leader>d', '<cmd>call DeleteBufferAndUpdateLightline()<cr>')


  -- EasyMotion Keybindings
  noremap('', 'f', '<nop>')
  map('', 'f', '<Plug>(easymotion-f)')
  map('', 'F', '<Plug>(easymotion-F)')
  map('', 't', '<Plug>(easymotion-t)')
  map('', 'T', '<Plug>(easymotion-T)')
  map('', 's', '<Plug>(easymotion-lineanywhere)')
  map('', '<leader>j', '<Plug>(easymotion-j)')
  map('', '<leader>k', '<Plug>(easymotion-k)')

  -- Diary Keybinds
  map('n', '<leader>ww', '<Plug>VimwikiMakeDiaryNote')
  map('n', '<leader>wi', '<Plug>VimwikiDiaryIndex')
  map('n', '<leader>wt', '<Plug>VimwikiMakeTomorrowDiaryNote')
  map('n', '<leader>wy', '<Plug>VimwikiMakeYesterdayDiaryNote')
  map('n', '<leader>w<leader>w', '<Plug>VimwikiIndex')

  -- Quick Buffer Switching Keybindings
  map('n', '<leader>!', '<Plug>lightline#bufferline#go(1)')
  map('n', '<leader>@', '<Plug>lightline#bufferline#go(2)')
  map('n', '<leader>#', '<Plug>lightline#bufferline#go(3)')
  map('n', '<leader>$', '<Plug>lightline#bufferline#go(4)')
  map('n', '<leader>%', '<Plug>lightline#bufferline#go(5)')
  map('n', '<leader>^', '<Plug>lightline#bufferline#go(6)')
  map('n', '<leader>&', '<Plug>lightline#bufferline#go(7)')
  map('n', '<leader>*', '<Plug>lightline#bufferline#go(8)')
  map('n', '<leader>(', '<Plug>lightline#bufferline#go(9)')

  -- Telescope Keybinds
  snoremap('n', ',',
    "<cmd>lua require('telescope.builtin').buffers({})<cr>")
  snoremap('n', '<leader>ff',
    "<cmd>lua require('telescope.builtin').find_files({})<cr>")
  snoremap('n', '<leader>fg',
    "<cmd>lua require('telescope.builtin').grep_string({})<cr>")
  snoremap('n', '<leader>fp',
    "<cmd>lua require('telescope.builtin').git_files({})<cr>")
  snoremap('n', '<leader>fo',
    "<cmd>lua require('telescope.builtin').oldfiles({})<cr>")
  snoremap('n', '<leader>fP', "<cmd>Telescope projects<cr>")
  -- LSP Keybinds
  snoremap('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>')
  snoremap('n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
  snoremap('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<cr>')
  snoremap('n', '<bar>', '<cmd>lua vim.lsp.buf.hover()<cr>')
  -- TODO: Add keybinds to jump to next and previous lsp diagnostics
  -- Maybe this should be <c-n> and <c-p>? 
  map('n', '<leader>tl', '<Plug>(toggle-lsp-diag-default)')

  -- TODO: Rebind gd, etc to use LSP if available. 

  -- We keep quitting on accident. 
  -- TODO: Make this smarter, maybe? If we have more than a few buffers open,
  -- then we should not quit. 
  -- vim.cmd("cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>")

end

return M
