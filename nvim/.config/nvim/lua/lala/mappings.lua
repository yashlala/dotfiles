-- This file contains "vanilla" keymaps for Vim.

-- The maps here don't really fit into a bigger picture.
-- If they do, you'll probably find them in a dedicated file instead.

local M = function()
  local function map(mode, key, value)
    if type(mode) ~= 'table' then
      mode = { mode }
    end
    for _, m in pairs(mode) do
      vim.api.nvim_set_keymap(m, key, value, { noremap = false })
    end
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

  snoremap('n', '<space>', '<nop>')

  noremap('', "'", '`')
  noremap('', '`', '~')
  noremap('', '-', '0')

  noremap('', ';', ':')
  noremap('n', ':', '@:')
  snoremap('n', 'q;', 'q:')

  noremap('n', '<bar>', 'K')
  noremap('n', 'K', 'kJ')
  noremap('n', 'U', '<c-r>')
  noremap('n', 'V', 'v')
  noremap('n', 'v', 'V')

  noremap('v', '<c-g>', 'g<c-g>')

  snoremap('n', 'gs', ':%s/') -- "Go :s"
  snoremap('n', 'gG', ':%g/') -- "Go :g"
  snoremap('n', 'gl', ':lua ') -- "Go lua"
  snoremap('n', 'gh', '<cmd>cd %:h<cr>') -- "Go Here"
  map('n', 'ga', '<Plug>(EasyAlign)') -- "Go align"

  -- Mark the entire file with Harpoon.
  snoremap('n', 'M', '<cmd>lua require("harpoon.mark").add_file()<cr>')
  -- Bring up the Harpoon menu for quick switching.
  snoremap('n', 'H', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>')

  snoremap('n', '<c-n>', '<cmd>cnext<cr>')
  snoremap('n', '<c-p>', '<cmd>cprev<cr>')
  noremap('n', '<c-]>', 'g<c-]>')
  noremap('n', 'g<c-]>', '<c-]>')

  snoremap('', '&', '<cmd>&&<cr>')
  noremap('', '_', '<c-y>')
  noremap('', '+', '<c-e>')

  -- Use Meta for easy window operations
  local nitvmapper = function(lhs, rhs)
    noremap('n', lhs, rhs)
    noremap('i', lhs, '<esc>' .. rhs)
    noremap('t', lhs, '<c-\\><c-n>' .. rhs)
    noremap('v', lhs, '<esc>' .. rhs)
  end

  nitvmapper('<m-h>', '<c-w>h') -- Easy movement
  nitvmapper('<m-j>', '<c-w>j')
  nitvmapper('<m-k>', '<c-w>k')
  nitvmapper('<m-l>', '<c-w>l')

  nitvmapper('<m-s>', '<c-w>s') -- Split
  nitvmapper('<m-v>', '<c-w>v') -- Vertical
  nitvmapper('<m-c>', '<c-w>c') -- Close
  nitvmapper('<m-x>', '<c-w>x') -- X-change
  nitvmapper('<m-t>', '<cmd>tab split<cr>') -- Tab

  vim.api.nvim_command([[
    function! ToggleQFList()
      if empty(filter(getwininfo(), 'v:val.quickfix'))
          copen
      else
          cclose
      endif
    endfunction
  ]])
  vim.api.nvim_command([[
    function! ToggleLocList()
      if empty(filter(getwininfo(), 'v:val.loclist'))
          lopen
      else
          lclose
      endif
    endfunction
  ]])
  nitvmapper('<m-q>', '<cmd>call ToggleQFList()<cr>')
  nitvmapper('<c-q>', '<cmd>call ToggleQFList()<cr>')
  nitvmapper('<m-r>', '<cmd>call ToggleLocList()<cr>')
  nitvmapper('<c-r>', '<cmd>call ToggleLocList()<cr>')
  snoremap('n', 'Q', '<cmd>cexpr [] | cclose<cr>') -- clear the quickfix list
  snoremap('n', 'L', '<cmd>lexpr [] | lclose<cr>') -- clear the location list

  noremap('n', '<m-space>', '<nop>') -- prevent current mode confusion
  noremap('i', '<m-space>', '<esc>') -- just keep mashing, we'll get to normal
  noremap('t', '<m-space>', '<c-\\><c-n>')
  noremap('t', '<c-space>', '<c-\\><c-n>')

  -- Simple Leader Keybinds
  snoremap('', '<leader>p', '"0p')
  snoremap('', '<leader>P', '"0P')
  smap('n', '<leader>gg', '<cmd>G<cr>')

  -- Delete the current buffer, close the current window/tab, clear loclist.
  -- Smart command, use it as a generic "get out of my face" inator.
  snoremap('n', '<leader>s', '<cmd>Sayonara<cr>')
  -- Delete the current buffer, preserve the window layout (smarter :bd)
  -- Use when we want to delete _buffer_ but preserve everything else.
  snoremap('n', '<leader>d', '<cmd>Sayonara!<cr>')
  -- Close the current window. Change nothing.
  -- Use when we want to delete window only.
  snoremap('n', '<leader>c', '<cmd>close<cr>')
  -- Create new tab.
  snoremap('n', '<leader>o', '<cmd>tab split<cr>')
  -- Create new window.
  snoremap('n', '<leader>O', '<cmd>silent !uwin<cr>')

  -- Quick Tab Switching Keybindings
  snoremap('n', '<leader>1', '1gt')
  snoremap('n', '<leader>2', '2gt')
  snoremap('n', '<leader>3', '3gt')
  snoremap('n', '<leader>4', '4gt')
  snoremap('n', '<leader>5', '5gt')
  snoremap('n', '<leader>6', '6gt')
  snoremap('n', '<leader>7', '7gt')
  snoremap('n', '<leader>8', '8gt')
  snoremap('n', '<leader>9', '9gt')
  snoremap('n', '<leader>0', '10gt')

  -- Quick Harpooned file access.
  snoremap('n', '<leader>h1', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>')
  snoremap('n', '<leader>h2', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>')
  snoremap('n', '<leader>h3', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>')
  snoremap('n', '<leader>h4', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>')
  snoremap('n', '<leader>h5', '<cmd>lua require("harpoon.ui").nav_file(5)<cr>')
  snoremap('n', '<leader>h6', '<cmd>lua require("harpoon.ui").nav_file(6)<cr>')
  snoremap('n', '<leader>h7', '<cmd>lua require("harpoon.ui").nav_file(7)<cr>')
  snoremap('n', '<leader>h8', '<cmd>lua require("harpoon.ui").nav_file(8)<cr>')
  snoremap('n', '<leader>h9', '<cmd>lua require("harpoon.ui").nav_file(9)<cr>')
  snoremap('n', '<leader>h0', '<cmd>lua require("harpoon.ui").nav_file(10)<cr>')

  -- Quick terminal access. Creates terminals if they don't exist yet.
  -- ToggleTerm.lua also provides us with <leader>tt, not shown here.
  snoremap('n', '<leader>t1', '<cmd>lua require("harpoon.term").gotoTerminal(1)<cr>')
  snoremap('n', '<leader>t2', '<cmd>lua require("harpoon.term").gotoTerminal(2)<cr>')
  snoremap('n', '<leader>t3', '<cmd>lua require("harpoon.term").gotoTerminal(3)<cr>')
  snoremap('n', '<leader>t4', '<cmd>lua require("harpoon.term").gotoTerminal(4)<cr>')
  snoremap('n', '<leader>t5', '<cmd>lua require("harpoon.term").gotoTerminal(5)<cr>')
  snoremap('n', '<leader>t6', '<cmd>lua require("harpoon.term").gotoTerminal(6)<cr>')
  snoremap('n', '<leader>t7', '<cmd>lua require("harpoon.term").gotoTerminal(7)<cr>')
  snoremap('n', '<leader>t8', '<cmd>lua require("harpoon.term").gotoTerminal(8)<cr>')
  snoremap('n', '<leader>t9', '<cmd>lua require("harpoon.term").gotoTerminal(9)<cr>')
  snoremap('n', '<leader>t0', '<cmd>lua require("harpoon.term").gotoTerminal(10)<cr>')

  -- Hop Keybindings
  noremap('', 'f', '<cmd>HopChar1AC<cr>')
  noremap('', 'F', '<cmd>HopChar1BC<cr>')
  noremap('n', 't', '<cmd>HopChar2AC<cr>')
  noremap('n', 'T', '<cmd>HopChar2BC<cr>')
  -- In operator-pending mode, these work like ordinary vim.
  noremap('o', 'f', "<cmd>lua require'hop'.hint_char1({direction = require'hop.hint'.HintDirection.AFTER_CURSOR, inclusive_jump = true })<cr>")
  noremap('o', 'F', "<cmd>lua require'hop'.hint_char1({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, inclusive_jump = true })<cr>")
  noremap('o', 't', "<cmd>lua require'hop'.hint_char1({direction = require'hop.hint'.HintDirection.AFTER_CURSOR, inclusive_jump = false })<cr>")
  noremap('o', 'T', "<cmd>lua require'hop'.hint_char1({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, inclusive_jump = false })<cr>")
  noremap('', '<leader>j', '<cmd>HopLineAC<cr>')
  noremap('', '<leader>k', '<cmd>HopLineBC<cr>')

  map('n', 's', '<Plug>(SubversiveSubstitute)')
  map('n', 'ss', '<Plug>(SubversiveSubstituteLine)')
  map('n', 'S', '<Plug>(SubversiveSubstituteToEndOfLine)')

  -- Diary Keybinds
  map('n', '<leader>ww', '<cmd>VimwikiMakeDiaryNote 1<cr>')
  map('n', '<leader>wi', '<cmd>VimwikiDiaryIndex 1<cr>')
  map('n', '<leader>wt', '<cmd>VimwikiMakeTomorrowDiaryNote 1<cr>')
  map('n', '<leader>wy', '<cmd>VimwikiMakeYesterdayDiaryNote 1<cr>')
  map('n', '<leader>w<leader>w', '<cmd>VimwikiIndex 1<cr>')
  -- Vimwiki uses <tab> to go to the next link, but <c-i> and <tab> are the
  -- same for the terminal. Disable the <tab> keybind by assigning it to
  -- something else before vimwiki is loaded. 
  map('n', '<leader>wn',  '<Plug>VimwikiNextLink')
  map('n', '<leader>wp',  '<Plug>VimwikiNextLink')


  -- Telescope Keybinds
  -- TODO: Can we use this to find _every_ picker, not just builtin ones?
  snoremap('n', '<leader><leader>', '<cmd>Telescope<cr>')
  -- TODO: Can we make this use LRU or frecency?
  -- TODO: Define a custom path displayer that combines the smartness of
  --       "truncate" with the selectiveness of "shorten". Can just pass
  --       a function argument...
  -- TODO: Can we define a keybind to kill buffers easily?
  -- We'll use this as our _primary_ method of navigation, so we should make it
  -- damn nice. EDIT: Well that turned out to be a lie, harpoon + tabs is great
  snoremap('n', ',',
    "<cmd>lua require('telescope.builtin').buffers({preview={hide_on_startup=true}, path_display = {'absolute', 'truncate'}})<cr>")
  -- Find old files (recently used)
  snoremap('n', '<leader>fo',
    "<cmd>lua require('telescope.builtin').oldfiles({preview={hide_on_startup=true}})<cr>")
  -- Find File
  snoremap('n', '<leader>ff',
    "<cmd>lua require('telescope.builtin').find_files({hidden = true, preview={hide_on_startup=true}})<cr>")
  -- Find Here (Buffer's dir is the CWD)
  snoremap('n', '<leader>fh',
    "<cmd>lua require('lala.telescope-custom').find_files_bufdir({hidden = true, preview={hide_on_startup=true}})<cr>")
  -- Find nvim dotfiles
  snoremap('n', '<leader>fd',
    "<cmd>lua require('telescope.builtin').find_files({hidden = true, cwd='~/.config/nvim', preview={hide_on_startup=true}})<cr>")
  -- Find all dotfiles
  snoremap('n', '<leader>fD',
    "<cmd>lua require('telescope.builtin').find_files({hidden = true, cwd='~/.dotfiles', preview={hide_on_startup=true}})<cr>")
  -- Find in project
  snoremap('n', '<leader>fp',
    "<cmd>lua require('telescope.builtin').git_files({preview={hide_on_startup=true}})<cr>")
  -- Find in all known projects.
  snoremap('n', '<leader>fP', "<cmd>Telescope projects<cr>")
  -- TODO: Make our file browser even better!
  -- Can we get the preview window to show the CWD?
  snoremap('n', '<leader>fb',
    "<cmd>lua require('telescope').extensions.file_browser.file_browser({preview={hide_on_startup=true}})<cr>")
  -- Find String
  snoremap('n', '<leader>fs',
    "<cmd>lua require('telescope.builtin').live_grep({hidden = true})<cr>")
  -- TODO: 2-layer find word with the grep_string. First, we prompt for the
  -- string to search with lua, then we search through those results.
  snoremap('n', '<leader>fS',
    "<cmd>lua require('telescope.builtin').grep_string({hidden = true})<cr>")
    -- Find word in _current buffer only
  snoremap('n', '<leader>fw',
    "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({})<cr>")

  -- LSP Keybinds
  snoremap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
  snoremap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
  snoremap('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<cr>')
  snoremap('n', '<bslash>', '<cmd>lua vim.lsp.buf.hover()<cr>')
  snoremap('n', '<bar>', '<cmd>lua vim.diagnostic.open_float()<cr>')
  -- TODO: Add keybinds to jump to next and previous lsp diagnostics
  -- Maybe this should be <c-n> and <c-p>?
  map('n', '<leader>tl', '<Plug>(toggle-lsp-diag-default)')

  -- We keep quitting on accident.
  -- TODO: Make this smarter, maybe? If we have more than a few buffers open,
  -- then we should not quit.
  -- vim.cmd("cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>")
end

return M
