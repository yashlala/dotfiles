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
  -- "Available" (unmapped) normal mode keys: 
  -- U, S, V. Potentially H, M, L?

  vim.api.nvim_command([[
    function! ToggleQuickFix()
      if empty(filter(getwininfo(), 'v:val.quickfix'))
          copen
      else
          cclose
      endif
    endfunction
  ]])
  snoremap('n', '<c-q>', '<cmd>call ToggleQuickFix()<cr>')
  snoremap('n', 'Q', '<cmd>cexpr [] | cclose<cr>') -- clear the quickfix list(s)
  -- TODO: Rebind these to our own functions. 
  -- If there's something in the quickfix list, it should go through the list. 
  -- If there's something in the location list, it should go through that. 
  -- If both are empty, it should just go through the neovim LSP diagnostics. 
  -- Great stuff!
  snoremap('n', '<c-n>', '<cmd>cnext<cr>')
  snoremap('n', '<c-p>', '<cmd>cprev<cr>')

  noremap('n', 'gs', ':%s/')
  map('n', 'ga', '<Plug>(EasyAlign)')

  snoremap('', '&', '<cmd>&&<cr>')
  noremap('', '_', '<c-y>')
  noremap('', '+', '<c-e>')

  -- Use Meta for easy window operations

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
  noremap('t', '<c-space>', '<c-\\><c-n>')
  noremap('n', '<c-\\>', '<nop>') 
  noremap('i', '<c-\\>', '<esc>') 
  noremap('t', '<c-\\>', '<c-\\><c-n>')


  -- Simple Leader Keybinds
  snoremap('', '<leader>p', '"0p')
  snoremap('', '<leader>P', '"0P')
  smap('n', '<leader>gg', '<cmd>G<cr>')
  smap('n', '<leader>o', '<cmd>silent !uwin<cr>')
  smap('n', '<leader>d', '<cmd>silent bdelete<cr>')

  -- Quick Tab Switching Keybindings
  snoremap('n', '<leader>!', '1gt')
  snoremap('n', '<leader>@', '2gt')
  snoremap('n', '<leader>#', '3gt')
  snoremap('n', '<leader>$', '4gt')
  snoremap('n', '<leader>%', '5gt')
  snoremap('n', '<leader>^', '6gt')
  snoremap('n', '<leader>&', '7gt')
  snoremap('n', '<leader>*', '8gt')
  snoremap('n', '<leader>(', '9gt')
  snoremap('n', '<leader>)', '10gt')

  -- Hop Keybindings
  -- TODO: Set up colors properly. 

  --[[ noremap('', 'f', '<cmd>HopChar1AC<cr>')
  noremap('', 'F', '<cmd>HopChar1BC<cr>')

  noremap('', 't', '<Plug>(easymotion-t)')
  noremap('', 'T', '<Plug>(easymotion-T)') ]]

  -- TODO: Make the `t` command work as expected. 
  -- TODO: Also, can we just use plain lua functions instead of stringifying
  -- here? 
  -- TODO: Looks like there's a PR for this? 
  -- vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({direction = require'hop.hint'.HintDirection.AFTER_CURSOR, inclusive_jump = true })<cr>", {})
  -- vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, inclusive_jump = true })<cr>", {})

  -- TODO: Jump to beginning _and_ end of words. 
  --[[ noremap('', 's', '<cmd>HopWordCurrentLine<cr>')
  map('', 's', '<Plug>(easymotion-lineanywhere)')
  noremap('', '<leader>j', '<cmd>HopLineAC<cr>')
  noremap('', '<leader>k', '<cmd>HopLineBC<cr>') ]]

  -- Diary Keybinds
  map('n', '<leader>ww', '<Plug>VimwikiMakeDiaryNote')
  map('n', '<leader>wi', '<Plug>VimwikiDiaryIndex')
  map('n', '<leader>wt', '<Plug>VimwikiMakeTomorrowDiaryNote')
  map('n', '<leader>wy', '<Plug>VimwikiMakeYesterdayDiaryNote')
  map('n', '<leader>w<leader>w', '<Plug>VimwikiIndex')


  -- Telescope Keybinds
  -- TODO: Can we use this to find _every_ picker, not just builtin ones?
  snoremap('n', '<leader><leader>', "<cmd>Telescope<cr>")
  -- TODO: Can we make this use LRU or frecency? 
  -- TODO: Define a custom path displayer that combines the smartness of
  --       "truncate" with the selectiveness of "shorten"
  -- We'll use this as our _primary_ method of navigation, so we should make it
  -- damn nice. 
  snoremap('n', ',',
    "<cmd>lua require('telescope.builtin').buffers({path_display = {'truncate', 'shorten', 'smart'}})<cr>")
  -- Find File
  snoremap('n', '<leader>ff',
    "<cmd>lua require('telescope.builtin').find_files({})<cr>")
  -- Find Here (Buffer's dir is the CWD)
  snoremap('n', '<leader>fh', 
    "<cmd>lua require('lala.telescope-custom').find_files_bufdir()<cr>")
  -- TODO: Make our file browser even better!
  -- Can we get the preview window to show the CWD? 
  snoremap('n', '<leader>fb',
    "<cmd>lua require('telescope.builtin').file_browser({})<cr>")
  -- Find String
  snoremap('n', '<leader>fs',
    "<cmd>lua require('telescope.builtin').live_grep({})<cr>")
  -- TODO: 2-layer find word with the grep_string. First, we prompt for the
  -- string to search with lua, then we search through those results. 
  snoremap('n', '<leader>fW',
    "<cmd>lua require('telescope.builtin').grep_string({})<cr>")
  -- Find Gitfile
  snoremap('n', '<leader>fg',
    "<cmd>lua require('telescope.builtin').git_files({})<cr>")
  -- Find recently used file. 
  snoremap('n', '<leader>fo',
    "<cmd>lua require('telescope.builtin').oldfiles({})<cr>")
  -- Find recently used project. 
  snoremap('n', '<leader>fp', "<cmd>Telescope projects<cr>")

  -- LSP Keybinds
  snoremap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
  snoremap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
  snoremap('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<cr>')
  snoremap('n', '<bar>', '<cmd>lua vim.lsp.buf.hover()<cr>')
  -- TODO: Add keybinds to jump to next and previous lsp diagnostics
  -- Maybe this should be <c-n> and <c-p>? 
  map('n', '<leader>tl', '<Plug>(toggle-lsp-diag-default)')

  -- We keep quitting on accident. 
  -- TODO: Make this smarter, maybe? If we have more than a few buffers open,
  -- then we should not quit. 
  -- vim.cmd("cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>")

  -- Swap digits and special characters. We need to do this in `langmap` (as
  -- opposed to regular bindings) because Vim isn't able to map all of its modes.
  -- map them all (eg: operator-pending for some reason doesn't remap di
  vim.o.langremap = false
  vim.o.langmap = '1!,!1,2@,@2,3#,#3,$4,4$,5%,%5,6^,^6,7&,&7,8*,*8,9(,(9,0),)0'
end

return M