-- This file contains "vanilla" keymaps for Vim.

-- The maps here don't really fit into a bigger picture.
-- If they do, you'll probably find them in a dedicated file instead.

local M = function()
  vim.keymap.set('', "'", '`')
  vim.keymap.set('', '`', '~')
  vim.keymap.set('', '-', '0')

  vim.keymap.set('', ';', ':')
  vim.keymap.set('n', ':', 'q:')
  vim.keymap.set('n', 'L', ':lua ')

  vim.keymap.set('n', '@;', '@:')
  vim.keymap.set('n', '<bar>', 'K')
  vim.keymap.set('n', 'K', 'kJ')
  vim.keymap.set('n', 'U', '<c-r>')
  vim.keymap.set('n', 'V', 'v')
  vim.keymap.set('n', 'v', 'V')

  vim.keymap.set('v', '<c-g>', 'g<c-g>')

  vim.keymap.set('n', 'gl', ':%') -- "Global" LMAO
  vim.keymap.set('n', 'gs', ':%s/') -- "Global :s"
  vim.keymap.set('n', 'gG', ':%g/') -- "Global :g"
  vim.keymap.set('n', 'gh', '<cmd>cd %:h<cr>') -- "Go Here"
  vim.keymap.set({'n', 'v'}, 'ga', '<Plug>(EasyAlign)') -- "Go align"

  -- Mark the entire file with Harpoon.
  vim.keymap.set('n', 'M',  require('harpoon.mark').add_file)
  -- Bring up the Harpoon menu for quick switching.
  vim.keymap.set('n', 'H', require('harpoon.ui').toggle_quick_menu)

  vim.keymap.set('n', '<c-n>', '<cmd>cnext<cr>')
  vim.keymap.set('n', '<c-p>', '<cmd>cprev<cr>')
  vim.keymap.set('n', '<c-]>', 'g<c-]>')
  vim.keymap.set('n', 'g<c-]>', '<c-]>')
  vim.keymap.set('n', 'g<c-o>', 'g;') -- <c-o>, but for changelist
  vim.keymap.set('n', 'g<c-i>', 'g,') -- <c-i>, but for changelist

  vim.keymap.set('', '&', '<cmd>&&<cr>')
  vim.keymap.set('', '_', '<c-y>')
  vim.keymap.set('', '+', '<c-e>')

  -- Use Meta for easy window operations
  local nitvmapper = function(lhs, rhs)
    vim.keymap.set('n', lhs, rhs)
    vim.keymap.set('i', lhs, '<esc>' .. rhs)
    vim.keymap.set('t', lhs, '<c-\\><c-n>' .. rhs)
    vim.keymap.set('v', lhs, '<esc>' .. rhs)
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

  local get_list_toggler = function(list)
    return function()
      if vim.fn.empty(vim.fn.filter(vim.fn.getwininfo(), 'v:val.' .. list)) == 1 then
        vim.cmd('copen')
      else
        vim.cmd('cclose')
      end
    end
  end

  vim.keymap.set('n', '<c-q>', get_list_toggler('quickfix'), 
    { desc = 'Toggle quickfix list visibility' })
  vim.keymap.set('n', '<c-r>', get_list_toggler('loclist'), 
    { desc = 'Toggle location list visibility' })

  -- TODO: convert the keys into lua

  nitvmapper('<m-q>', '<cmd>call ToggleQFList()<cr>')
  nitvmapper('<m-r>', '<cmd>call ToggleLocList()<cr>')

  vim.keymap.set('n', '<m-space>', '<nop>') -- prevent current mode confusion
  vim.keymap.set('i', '<m-space>', '<esc>') -- just keep mashing, we'll get to normal
  vim.keymap.set('t', '<m-space>', '<c-\\><c-n>')
  vim.keymap.set('t', '<c-space>', '<c-\\><c-n>')

  -- Simple Leader Keybinds
  vim.keymap.set('', '<leader>y', '"+y')
  vim.keymap.set('', '<leader>Y', '"+y$')
  vim.keymap.set('', '<leader>p', '"+p')
  vim.keymap.set('', '<leader>P', '"+P')
  vim.keymap.set('n', '<leader>gg', '<cmd>G<cr>')

  -- Delete the current buffer, close the current window/tab, clear loclist.
  -- Smart command, use it as a generic "get out of my face" inator.
  vim.keymap.set('n', '<leader>s', '<cmd>Sayonara<cr>')
  -- Delete the current buffer, preserve the window layout (smarter :bd)
  -- Use when we want to delete _buffer_ but preserve everything else.
  vim.keymap.set('n', '<leader>d', '<cmd>Sayonara!<cr>')
  -- Close the current window. Change nothing.
  -- Use when we want to delete window only.
  vim.keymap.set('n', '<leader>c', '<cmd>close<cr>')
  -- Create new tab.
  vim.keymap.set('n', '<leader>o', '<cmd>tab split<cr>')
  -- Create new window.
  vim.keymap.set('n', '<leader>O', '<cmd>silent !uwin<cr>')

  -- Quick Tab Switching Keybindings
  vim.keymap.set('n', '<leader>1', '1gt')
  vim.keymap.set('n', '<leader>2', '2gt')
  vim.keymap.set('n', '<leader>3', '3gt')
  vim.keymap.set('n', '<leader>4', '4gt')
  vim.keymap.set('n', '<leader>5', '5gt')
  vim.keymap.set('n', '<leader>6', '6gt')
  vim.keymap.set('n', '<leader>7', '7gt')
  vim.keymap.set('n', '<leader>8', '8gt')
  vim.keymap.set('n', '<leader>9', '9gt')
  vim.keymap.set('n', '<leader>0', '10gt')

  -- Quick Harpooned file access.
  vim.keymap.set('n', '<leader>h1', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>')
  vim.keymap.set('n', '<leader>h2', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>')
  vim.keymap.set('n', '<leader>h3', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>')
  vim.keymap.set('n', '<leader>h4', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>')
  vim.keymap.set('n', '<leader>h5', '<cmd>lua require("harpoon.ui").nav_file(5)<cr>')
  vim.keymap.set('n', '<leader>h6', '<cmd>lua require("harpoon.ui").nav_file(6)<cr>')
  vim.keymap.set('n', '<leader>h7', '<cmd>lua require("harpoon.ui").nav_file(7)<cr>')
  vim.keymap.set('n', '<leader>h8', '<cmd>lua require("harpoon.ui").nav_file(8)<cr>')
  vim.keymap.set('n', '<leader>h9', '<cmd>lua require("harpoon.ui").nav_file(9)<cr>')
  vim.keymap.set('n', '<leader>h0', '<cmd>lua require("harpoon.ui").nav_file(10)<cr>')

  -- Quick terminal access. Creates terminals if they don't exist yet.
  -- ToggleTerm.lua also provides us with <leader>tt, not shown here.
  vim.keymap.set('n', '<leader>t1', '<cmd>lua require("harpoon.term").gotoTerminal(1)<cr>')
  vim.keymap.set('n', '<leader>t2', '<cmd>lua require("harpoon.term").gotoTerminal(2)<cr>')
  vim.keymap.set('n', '<leader>t3', '<cmd>lua require("harpoon.term").gotoTerminal(3)<cr>')
  vim.keymap.set('n', '<leader>t4', '<cmd>lua require("harpoon.term").gotoTerminal(4)<cr>')
  vim.keymap.set('n', '<leader>t5', '<cmd>lua require("harpoon.term").gotoTerminal(5)<cr>')
  vim.keymap.set('n', '<leader>t6', '<cmd>lua require("harpoon.term").gotoTerminal(6)<cr>')
  vim.keymap.set('n', '<leader>t7', '<cmd>lua require("harpoon.term").gotoTerminal(7)<cr>')
  vim.keymap.set('n', '<leader>t8', '<cmd>lua require("harpoon.term").gotoTerminal(8)<cr>')
  vim.keymap.set('n', '<leader>t9', '<cmd>lua require("harpoon.term").gotoTerminal(9)<cr>')
  vim.keymap.set('n', '<leader>t0', '<cmd>lua require("harpoon.term").gotoTerminal(10)<cr>')

  -- Hop Keybindings
  vim.keymap.set('', 'f', '<cmd>HopChar1AC<cr>')
  vim.keymap.set('', 'F', '<cmd>HopChar1BC<cr>')
  vim.keymap.set('n', 't', '<cmd>HopChar2AC<cr>')
  vim.keymap.set('n', 'T', '<cmd>HopChar2BC<cr>')
  -- In operator-pending mode, these work like ordinary vim.
  vim.keymap.set('o', 'f', function()
    require('hop').hint_char1({
      direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
      inclusive_jump = true
    })
  end)
  vim.keymap.set('o', 'F', function()
    require('hop').hint_char1({
      direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
      inclusive_jump = true
    })
  end)
  vim.keymap.set('o', 't', function()
    require('hop').hint_char1({
      direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
      inclusive_jump = false
    })
  end)
  vim.keymap.set('o', 'T', function()
    require('hop').hint_char1({
      direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
      inclusive_jump = false
    })
  end)
  vim.keymap.set('', '<leader>j', '<cmd>HopLineAC<cr>')
  vim.keymap.set('', '<leader>k', '<cmd>HopLineBC<cr>')

  vim.keymap.set('n', 's', '<Plug>(SubversiveSubstitute)')
  vim.keymap.set('n', 'ss', '<Plug>(SubversiveSubstituteLine)')
  vim.keymap.set('n', 'S', '<Plug>(SubversiveSubstituteToEndOfLine)')

  -- Diary Keybinds
  vim.keymap.set('n', '<leader>ww', '<cmd>VimwikiMakeDiaryNote 1<cr>')
  vim.keymap.set('n', '<leader>wi', '<cmd>VimwikiDiaryIndex 1<cr>')
  vim.keymap.set('n', '<leader>wt', '<cmd>VimwikiMakeTomorrowDiaryNote 1<cr>')
  vim.keymap.set('n', '<leader>wy', '<cmd>VimwikiMakeYesterdayDiaryNote 1<cr>')
  vim.keymap.set('n', '<leader>w<leader>w', '<cmd>VimwikiIndex 1<cr>')
  -- Vimwiki uses <tab> to go to the next link, but <c-i> and <tab> are the
  -- same for the terminal. Disable the <tab> keybind by assigning it to
  -- something else before vimwiki is loaded.
  vim.keymap.set('n', '<leader>wn',  '<Plug>VimwikiNextLink')
  vim.keymap.set('n', '<leader>wp',  '<Plug>VimwikiNextLink')


  -- Telescope Keybinds
  -- TODO: Can we use this to find _every_ picker, not just builtin ones?
  vim.keymap.set('n', '<leader><leader>', '<cmd>Telescope<cr>')
  -- TODO: Can we make this use LRU or frecency?
  -- TODO: Define a custom path displayer that combines the smartness of
  --       "truncate" with the selectiveness of "shorten". Can just pass
  --       a function argument...
  -- TODO: Can we define a keybind to kill buffers easily?
  -- We'll use this as our _primary_ method of navigation, so we should make it
  -- damn nice. EDIT: Well that turned out to be a lie, harpoon + tabs is great
  vim.keymap.set('n', ',', 
    function()
      require('telescope.builtin').buffers({
        preview={hide_on_startup=true},
        path_display = {'absolute', 'truncate'}
      })
    end, 
    { desc = 'View buffers' }
  )
  -- Find old files (recently used)
  vim.keymap.set('n', '<leader>fo', 
    function()
      require('telescope.builtin').oldfiles({preview={hide_on_startup=true}})
    end, 
    { desc = 'Find old files' }
  )
  -- Find File
  vim.keymap.set('n', '<leader>ff', function()
    require('telescope.builtin').find_files({
      preview={hide_on_startup=true},
      hidden = true,
    })
  end)
  -- Find Here (Buffer's dir is the CWD)
  vim.keymap.set('n', '<leader>fh', function()
    require('lala.telescope-custom').find_files_bufdir({
      preview={hide_on_startup=true},
      hidden = true,
    })
  end)
  -- Find nvim dotfiles
  vim.keymap.set('n', '<leader>fd', function()
    require('telescope.builtin').find_files({
      preview={hide_on_startup=true},
      hidden = true,
      cwd='~/.config/nvim',
    })
  end)
  -- Find all dotfiles
  vim.keymap.set('n', '<leader>fD', function()
    require('telescope.builtin').find_files({
      preview={hide_on_startup=true},
      hidden = true,
      cwd='~/.dotfiles',
    })
  end)
  -- Find in project
  vim.keymap.set('n', '<leader>fp', function()
    require('telescope.builtin').git_files({preview={hide_on_startup=true}})
  end)
  -- Find in all known projects.
  vim.keymap.set('n', '<leader>fP', "<cmd>Telescope projects<cr>")
  -- TODO: Make our file browser even better!
  -- Can we get the preview window to show the CWD?
  vim.keymap.set('n', '<leader>fb', function()
    require('telescope').extensions.file_browser.file_browser({
      preview={hide_on_startup=true}
    })
  end)
  -- Find String
  vim.keymap.set('n', '<leader>fs', function()
    require('telescope.builtin').live_grep({hidden = true})
  end)
  -- TODO: 2-layer find word with the grep_string. First, we prompt for the
  -- string to search with lua, then we search through those results.
  vim.keymap.set('n', '<leader>fS', function()
    require('telescope.builtin').grep_string({hidden = true})
  end)
    -- Find word in _current buffer only
  vim.keymap.set('n', '<leader>fw', function()
    require('telescope.builtin').current_buffer_fuzzy_find({})
  end)

  -- LSP Keybinds
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
  vim.keymap.set('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<cr>')
  vim.keymap.set('n', '<bslash>', '<cmd>lua vim.lsp.buf.hover()<cr>')
  vim.keymap.set('n', '<bar>', '<cmd>lua vim.diagnostic.open_float()<cr>')
  -- TODO: Add keybinds to jump to next and previous lsp diagnostics
  -- Maybe this should be <c-n> and <c-p>?
  vim.keymap.set('n', '<leader>tl', '<Plug>(toggle-lsp-diag-default)')

  -- We keep quitting on accident.
  -- TODO: Make this smarter, maybe? If we have more than a few buffers open,
  -- then we should not quit.
  -- vim.cmd("cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>")
end

return M
