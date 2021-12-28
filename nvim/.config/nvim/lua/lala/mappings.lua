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
  noremap('n', 'v', 'V')
  -- "Available" (unmapped) normal mode keys: U, S, V.

  noremap('n', 'gs', ':%s/')
  map('n', 'ga', '<Plug>(EasyAlign)')

  -- Mark the entire file with Harpoon.
  snoremap('n', 'M', '<cmd>lua require("harpoon.mark").add_file()<cr>')
  -- Bring up the Harpoon menu for quick switching.
  snoremap('n', 'H', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>')


  snoremap('n', 'Q', '<cmd>cexpr [] | cclose<cr>') -- clear the quickfix list
  snoremap('n', 'L', '<cmd>lexpr [] | lclose<cr>') -- clear the location list
  snoremap('n', '<c-n>', '<cmd>cnext<cr>')
  snoremap('n', '<c-p>', '<cmd>cprev<cr>')
  noremap('n', '<c-j>', '<cmd>lnext<cr>')
  noremap('n', '<c-k>', '<cmd>lprev<cr>')

  snoremap('', '&', '<cmd>&&<cr>')
  noremap('', '_', '<c-y>')
  noremap('', '+', '<c-e>')

  -- Use Meta for easy window operations
  local nitmapper = function(lhs, rhs)
    noremap('n', lhs, rhs)
    noremap('i', lhs, '<esc>' .. rhs)
    noremap('t', lhs, '<c-\\><c-n>' .. rhs)
  end

  nitmapper('<m-h>', '<c-w>h') -- Easy movement
  nitmapper('<m-j>', '<c-w>j')
  nitmapper('<m-k>', '<c-w>k')
  nitmapper('<m-l>', '<c-w>l')

  nitmapper('<m-s>', '<c-w>s') -- Split
  nitmapper('<m-v>', '<c-w>v') -- Vertical
  nitmapper('<m-c>', '<c-w>c') -- Close
  nitmapper('<m-x>', '<c-w>x') -- X-change
  nitmapper('<m-t>', '<cmd>tab split<cr>') -- Tab

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
  nitmapper('<m-q>', '<cmd>call ToggleQFList()<cr>')
  nitmapper('<m-r>', '<cmd>call ToggleLocList()<cr>')

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
  -- Close the current buffer. This can close the window too.
  smap('n', '<leader>d', '<cmd>silent bd<cr>')
  -- Delete the current buffer, but leave the window untouched.
  -- TODO: Switch to the alternate buffer if it exists? If not, do bn.
  smap('n', '<leader>D', '<cmd>silent bn | bd#<cr>')

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

  -- Quick Harpooned file access.
  snoremap('n', '<leader>h!', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>')
  snoremap('n', '<leader>h@', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>')
  snoremap('n', '<leader>h#', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>')
  snoremap('n', '<leader>h$', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>')
  snoremap('n', '<leader>h%', '<cmd>lua require("harpoon.ui").nav_file(5)<cr>')
  snoremap('n', '<leader>h^', '<cmd>lua require("harpoon.ui").nav_file(6)<cr>')
  snoremap('n', '<leader>h&', '<cmd>lua require("harpoon.ui").nav_file(7)<cr>')
  snoremap('n', '<leader>h*', '<cmd>lua require("harpoon.ui").nav_file(8)<cr>')
  snoremap('n', '<leader>h(', '<cmd>lua require("harpoon.ui").nav_file(9)<cr>')
  snoremap('n', '<leader>h)', '<cmd>lua require("harpoon.ui").nav_file(10)<cr>')

  -- Quick terminal access. Creates terminals if they don't exist yet.
  -- TODO: Use <leader>tt to open a temporary terminal in a split.
  snoremap('n', '<leader>t!', '<cmd>lua require("harpoon.term").gotoTerminal(1)<cr>')
  snoremap('n', '<leader>t@', '<cmd>lua require("harpoon.term").gotoTerminal(2)<cr>')
  snoremap('n', '<leader>t#', '<cmd>lua require("harpoon.term").gotoTerminal(3)<cr>')
  snoremap('n', '<leader>t$', '<cmd>lua require("harpoon.term").gotoTerminal(4)<cr>')
  snoremap('n', '<leader>t%', '<cmd>lua require("harpoon.term").gotoTerminal(5)<cr>')
  snoremap('n', '<leader>t^', '<cmd>lua require("harpoon.term").gotoTerminal(6)<cr>')
  snoremap('n', '<leader>t&', '<cmd>lua require("harpoon.term").gotoTerminal(7)<cr>')
  snoremap('n', '<leader>t*', '<cmd>lua require("harpoon.term").gotoTerminal(8)<cr>')
  snoremap('n', '<leader>t(', '<cmd>lua require("harpoon.term").gotoTerminal(9)<cr>')
  snoremap('n', '<leader>t)', '<cmd>lua require("harpoon.term").gotoTerminal(10)<cr>')

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
  -- Find old files (recently used)
  snoremap('n', '<leader>fo',
    "<cmd>lua require('telescope.builtin').oldfiles({})<cr>")
  -- Find File
  snoremap('n', '<leader>ff',
    "<cmd>lua require('telescope.builtin').find_files({hidden = true})<cr>")
  -- Find Nvim Dotfile
  snoremap('n', '<leader>fd',
    "<cmd>lua require('telescope.builtin').find_files({hidden = true, cwd='~/.config/nvim'})<cr>")
  -- Find Here (Buffer's dir is the CWD)
  snoremap('n', '<leader>fh',
    "<cmd>lua require('lala.telescope-custom').find_files_bufdir({hidden = true)<cr>")
  -- TODO: Make our file browser even better!
  -- Can we get the preview window to show the CWD?
  snoremap('n', '<leader>fb',
    "<cmd>lua require('telescope').extensions.file_browser.file_browser()<cr>")
  -- Find String
  snoremap('n', '<leader>fs',
    "<cmd>lua require('telescope.builtin').live_grep({hidden = true})<cr>")
  -- TODO: 2-layer find word with the grep_string. First, we prompt for the
  -- string to search with lua, then we search through those results.
  snoremap('n', '<leader>fS',
    "<cmd>lua require('telescope.builtin').grep_string({hidden = true})<cr>")
  -- Find in project
  snoremap('n', '<leader>fp',
    "<cmd>lua require('telescope.builtin').git_files({})<cr>")
  -- Find in all known projects.
  snoremap('n', '<leader>fP', "<cmd>Telescope projects<cr>")

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

  -- Swap digits and special characters. We need to do this in `langmap` (as
  -- opposed to regular bindings) because Vim isn't able to map all of its modes.
  -- map them all (eg: operator-pending for some reason doesn't remap di
  -- TODO: If we set this to true, then everything works for us that failed
  -- before (eg: d9 should act like `d(`).
  -- I think we should set it to false. But.
  -- but set up operator pending mode maps as well?
  -- Apparently iminsert has something to do with this, too?
  -- vim.o.langremap = true
  vim.o.langremap = false
  vim.o.langmap = '1!,!1,2@,@2,3#,#3,$4,4$,5%,%5,6^,^6,7&,&7,8*,*8,9(,(9,0),)0'
end

return M
