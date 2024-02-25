-- This file contains "vanilla" keymaps for Vim.

-- The maps here don't really fit into a bigger picture.
-- If they do, you'll probably find them in a dedicated file instead.

-- NOTE: LuaSnip uses select-mode to highlight fields prior to replacing
-- them. Eg ([X] := "X is highlighted, visually):
--
--    for (int [varNameHere]; ...)
--
-- Mappings defined with `v(nore)map` apply to visual _and_ select modes. So
-- `vnoremap s <Plug>(SubversiveSubstitute)` will make it impossible to type
-- variable names starting with "s". Always use `xmap` instead of `vmap`
-- while we have LuaSnip installed. And always use {'n', 'v', 'o'} instead of
-- map('', ...).

local M = {}

M.setup = function()
  vim.keymap.del('', '<c-l>') -- Remove nvim default binding (we replace it)

  vim.keymap.set({'n', 'v', 'o'}, '<leader>', '<nop>')
  vim.keymap.set({'n', 'v', 'o'}, "'", '`')
  vim.keymap.set({'n', 'v', 'o'}, '`', '~')
  vim.keymap.set({'n', 'v', 'o'}, '-', '0')

  vim.keymap.set({'n', 'v', 'o'}, ';', ':')
  vim.keymap.set({'n', 'v', 'o'}, '<leader>;', ':lua ')
  vim.keymap.set({'n', 'v', 'o'}, '<leader>:', ':lua =')
  vim.keymap.set({'n', 'x'}, ':', 'q:')

  vim.keymap.set('n', '@;', '@:')
  vim.keymap.set('n', 'K', 'kJ')
  vim.keymap.set('n', 'gK', 'kgJ')
  vim.keymap.set('n', 'U', '<c-r>')
  -- TODO: vim-repeat overrides this like a dummy. Don't let it.
  vim.keymap.set('n', '<c-r>', -- "Refresh screen".
    '<cmd>nohlsearch|diffupdate|normal! <c-l><cr>')
  vim.keymap.set({'n', 'x', 'o'}, 'V', 'v')
  vim.keymap.set({'n', 'x', 'o'}, 'v', 'V')

  vim.keymap.set('x', '<c-g>', 'g<c-g>')
  vim.keymap.set('x', 'y', 'ygv<esc>') -- keep cursor at selection end

  vim.keymap.set({'n', 'x'}, 's', '<Plug>(SubversiveSubstitute)')
  vim.keymap.set('n', 'ss', '<Plug>(SubversiveSubstituteLine)')
  vim.keymap.set('n', 'S', '<Plug>(SubversiveSubstituteToEndOfLine)')

  vim.keymap.set('n', 'gl', ':%') -- "Global" LMAO
  vim.keymap.set('n', 'gs', ':%s/') -- "Global :s"
  vim.keymap.set('n', 'gG', ':%g/') -- "Global :g"
  vim.keymap.set('n', 'g/', ':silent grep! ') -- "Global /"
  vim.keymap.set('n', 'g?', ':silent grep!  %<left><left>') -- "Global /, better"
  vim.keymap.set('n', 'gh', '<cmd>cd %:h<cr>') -- "Go Here"
  vim.keymap.set({'n', 'x'}, 'ga', '<Plug>(EasyAlign)') -- "Go align"

  vim.keymap.set('n', '<leader>m',  function() require('marker').create_bookmark() end,
    { desc = 'Create bookmark' })
  vim.keymap.set('n', "<leader>'", function() require('marker').goto_bookmark() end,
    { desc = 'Goto bookmark' })
  vim.keymap.set('n', 'dm', function() require('marker').del_bookmark() end,
    { desc = 'Delete bookmark' })

  vim.keymap.set('n', 't', '<cmd>tags<cr>')
  vim.keymap.set('n', 'T', '<cmd>Cleartags<cr>')
  vim.api.nvim_create_user_command('Cleartags', function()
      vim.fn.settagstack(vim.fn.winnr(), {items = {}}, 'r')
      print('Tag stack cleared.')
    end,
    { desc = 'Empty the tag stack of the current window' })
  vim.keymap.set('n', '<leader>T', function()
    local tagname = vim.fn.input('Tag Name: ')
    local newtag = {{
      tagname = tagname,
      bufnr = vim.fn.bufnr('%'),
      from = vim.fn.getcurpos(),
    }}
    vim.fn.settagstack(vim.fn.winnr(), {items = newtag}, 't')
  end, { desc = 'Add current position tag stack' })

  vim.keymap.set('n', '<c-]>', 'g<c-]>')
  vim.keymap.set('n', 'g<c-]>', '<c-]>')
  vim.keymap.set('n', 'g<c-o>', 'g;') -- <c-o>, but for changelist
  vim.keymap.set('n', 'g<c-i>', 'g,') -- <c-i>, but for changelist
  vim.keymap.set('n', '<c-n>', vim.diagnostic.goto_next)
  vim.keymap.set('n', '<c-p>', vim.diagnostic.goto_prev)

  vim.keymap.set({'n', 'v', 'o'}, '_', '<c-y>')
  vim.keymap.set({'n', 'v', 'o'}, '+', '<c-e>')

  -- Use Meta for easy window movement operations
  local directions = { h='left', j='lower', k='upper', l='right' }
  for key, direction in pairs(directions) do
    local lhs = string.format('<m-%s>', key)
    local desc = string.format('Move to %s window', direction)
    vim.keymap.set({'n', 'i', 't', 'x'}, lhs, function()
      vim.cmd('wincmd ' .. key)
      -- TODO this is still broken.
      if vim.o.buftype == 'terminal' and vim.fn.mode('x') == 'n' then
        vim.fn.feedkeys('i') -- https://github.com/neovim/neovim/issues/4895
      else
        vim.cmd('stopinsert')
      end
    end, { desc = desc })
  end

  local nitx = { 'n', 'i', 't', 'x' }
  vim.keymap.set(nitx, '<m-s>', '<cmd>wincmd s<cr>', { desc = 'Split horizontally' })
  vim.keymap.set(nitx, '<m-v>', '<cmd>wincmd v<cr>', { desc = 'Split vertically' })
  vim.keymap.set(nitx, '<m-x>', '<cmd>wincmd x<cr>', { desc = 'Exchange window' })

  vim.keymap.set('n', '<c-q>', function()
      local win_info = vim.fn.filter(vim.fn.getwininfo(), 'v:val.quickfix')
      if vim.fn.empty(win_info) == 1 then
        vim.cmd('copen')
      else
        vim.cmd('cclose')
      end
    end, { desc = 'Toggle quickfix list visibility' })

  vim.keymap.set('n', '<m-space>', '<nop>') -- prevent current mode confusion
  vim.keymap.set('i', '<m-space>', '<esc>') -- just keep mashing, we'll get to normal
  vim.keymap.set('t', '<m-space>', '<c-\\><c-n>')
  vim.keymap.set('n', '<c-space>', '<nop>')
  vim.keymap.set('t', '<c-space>', '<c-\\><c-n>')

  vim.keymap.set('n', '<leader>n', '"_',
    { desc = 'Use null (black-hole) register' })
  vim.keymap.set('n', '<leader><c-g>', '1<c-g>',
    { desc = 'Print full path of current buffer' })
  vim.keymap.set({'n', 'x'}, '<leader>.', '@:',
    { desc = 'Repeat the last Ex command.' })

  -- X11 Clipboard management
  vim.keymap.set({'n', 'v', 'o'}, '<leader>y', '"+y',
    { desc = 'Yank to clipboard' })
  vim.keymap.set({'n', 'v', 'o'}, '<leader>Y', '"+y$',
    { desc = 'Yank end of line to clipboard' })
  vim.keymap.set({'n', 'v', 'o'}, '<leader>p', '"+p',
    { desc = 'Paste from clipboard' })
  vim.keymap.set({'n', 'v', 'o'}, '<leader>P', '"+P',
    { desc = 'Paste from clipboard behind cursor' })
  -- TODO set up mapping to paste default buffer too.
  vim.keymap.set('i', '<c-r><space>', '<c-r>+',
    { desc = 'Insert from clipboard' })
  vim.keymap.set('i', '<c-r><c-r><space>', '<c-r><c-r>+',
    { desc = 'Insert literally from clipboard' })
  vim.keymap.set({'n', 'v', 'o'}, '<leader>s', '"+<Plug>(SubversiveSubstitute)',
    { desc = 'Substitute with clipboard' })
  vim.keymap.set({'n', 'v', 'o'}, '<leader>ss', '"+<Plug>(SubversiveSubstituteLine)',
    { desc = 'Substitute line with clipboard' })
  vim.keymap.set({'n', 'v', 'o'}, '<leader>S', '"+<Plug>(SubversiveSubstituteToEndOfLine)',
    { desc = 'Substitute end of line with clipboard' })

  -- LSP management
  vim.keymap.set({'n', 'v', 'o'}, '<leader>ls', '<cmd>LspStart<cr>',
    { desc = 'Start the LSP' })
  vim.keymap.set({'n', 'v', 'o'}, '<leader>li', '<cmd>LspInfo<cr>',
    { desc = 'Display LSP status info' })
  vim.keymap.set({'n', 'v', 'o'}, '<leader>lr', '<cmd>LspRestart<cr>',
    { desc = 'Restart the running LSP' })
  vim.keymap.set({'n', 'v', 'o'}, '<leader>ll', '<cmd>LspLog<cr>',
    { desc = 'View LSP logfile' })

  -- Git repository management
  vim.keymap.set('n', '<leader>gg', '<cmd>G<cr>',
    { desc = 'Display Git status window' })
  -- Kernel repo history is too large for ":G lo". 
  vim.keymap.set('n', '<leader>gl',
    '<cmd>G log --abbrev-commit --pretty=oneline -500<cr>',
    { desc = 'Display the first 500 git commits' })
  vim.keymap.set('n', '<leader>gL',
    '<cmd>G log --abbrev-commit --pretty=oneline --first-parent -500<cr>',
    { desc = 'Display the first 500 git commits (first parent only)' })

  -- Smart command, use it as a generic "get out of my face" inator.
  vim.keymap.set('n', '<leader>q', '<cmd>Sayonara<cr>')
  -- Delete the current buffer, preserve the window layout (smarter :bd)
  -- Use when we want to delete _buffer_ but preserve everything else.
  vim.keymap.set('n', '<leader>d', '<cmd>Sayonara!<cr>')
  -- Delete the current buffer, close the current window/tab, clear loclist.
  -- Close the current window. Change nothing.
  -- Use when we want to delete window only.
  vim.keymap.set('n', '<leader>c', '<cmd>close<cr>')
  -- Create new tab.
  vim.keymap.set('n', '<leader>t', '<cmd>tab split<cr>')
  vim.keymap.set('n', '<leader>e', ':e %:h/',
    { desc = 'Edit a sibling file in the current directory' })

  vim.api.nvim_create_user_command('SyntaxReload', 'syntax sync fromstart',
    { desc = 'Reload highlighting from beginning of file' })
  vim.api.nvim_create_user_command('Rnlist', 'VimwikiRenumberList',
    { desc = 'Renumber a Vimwiki List' })
  vim.api.nvim_create_user_command('Rnlistall', 'VimwikiRenumberAllLists',
    { desc = 'Renumber all Vimwiki Lists in the buffer' })

  for i=1,10 do
    local key = i % 10

    -- Quick Tab Switching
    vim.keymap.set('n', '<leader>'..key , i..'gt')
    -- Quick Harpoon file access.
    vim.keymap.set('n', '<leader>h'..key,
      string.format("<cmd>lua require('harpoon.ui').nav_file(%d)<cr>", i),
      { desc = 'Go to Harpoon file '..key })
    -- Quick terminal access. Creates terminals if they don't exist yet.
    vim.keymap.set('n', '<leader><leader>'..key,
      string.format("<cmd>lua require('harpoon.term').gotoTerminal(%d)<cr>", i),
      { desc = 'Go to terminal ' .. key })
  end

  vim.keymap.set('n', '<leader>0',
    function()
      local bufpath = vim.api.nvim_buf_get_name(0)
      local dir_arg = ''
      if bufpath ~= '' and vim.fn.filereadable(bufpath) == 1 then
        dir_arg = 'dir=' .. vim.fn.fnameescape(vim.fs.dirname(bufpath))
      end
      vim.cmd('ToggleTerm ' .. dir_arg)
    end,
    { desc = "Open a ToggleTerm split at the current buffer" })

  -- Hop Keybindings
  vim.keymap.set({'n', 'v', 'o'}, 'f', '<cmd>HopChar1AC<cr>')
  vim.keymap.set({'n', 'v', 'o'}, 'F', '<cmd>HopChar1BC<cr>')
  -- In operator-pending mode, these work like ordinary vim.
  vim.keymap.set('o', 'f', function()
      require('hop').hint_char1({
        direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
        inclusive_jump = true
      })
    end, { desc = 'Delete forwards (inclusive)' })
  vim.keymap.set('o', 'F', function()
      require('hop').hint_char1({
        direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
        inclusive_jump = true
      })
    end, { desc = 'Delete backwards (inclusive)' })
  vim.keymap.set('o', 't', function()
      require('hop').hint_char1({
        direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
        hint_offset = -1,
      })
    end, { desc = 'Delete forwards (exclusive)' })
  vim.keymap.set('o', 'T', function()
      require('hop').hint_char1({
        direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
        hint_offset = 1,
      })
    end, { desc = 'Delete backwards (exclusive)' })
  vim.keymap.set({'n', 'v', 'o'}, '<leader>j', '<cmd>HopLineAC<cr>')
  vim.keymap.set({'n', 'v', 'o'}, '<leader>k', '<cmd>HopLineBC<cr>')

  -- Diary Keybinds
  vim.keymap.set('n', '<leader>ww', '<cmd>VimwikiMakeDiaryNote 1<cr>')
  vim.keymap.set('n', '<leader>wI', '<cmd>VimwikiDiaryIndex 1<cr>')
  vim.keymap.set('n', '<leader>wt', '<cmd>VimwikiMakeTomorrowDiaryNote 1<cr>')
  vim.keymap.set('n', '<leader>wy', '<cmd>VimwikiMakeYesterdayDiaryNote 1<cr>')

  vim.keymap.set('n', '<leader>w<leader>w', '<cmd>VimwikiIndex 1<cr>')
  vim.keymap.set('n', '<leader>wi', '<cmd>e ~/documents/vimwiki/Inbox.md<cr>')
  vim.keymap.set('n', '<leader>ws', '<cmd>e ~/documents/vimwiki/Status.md<cr>')
  vim.keymap.set('n', '<leader>wS', '<cmd>e ~/documents/vimwiki/Someday.md<cr>')

  -- Vimwiki uses <tab> to go to the next link, but <c-i> and <tab> are the
  -- same for the terminal. Disable the <tab> keybind by assigning it to
  -- something else before vimwiki is loaded.
  vim.keymap.set('n', '<leader>wn',  '<Plug>VimwikiNextLink')
  vim.keymap.set('n', '<leader>wp',  '<Plug>VimwikiNextLink')

  -- Telescope Keybinds
  -- TODO: Define a custom path displayer that combines the smartness of
  --       "truncate" with the selectiveness of "shorten". Can just pass
  --       a function argument...
  -- TODO: Can we define a keybind to kill buffers easily?
  vim.keymap.set('n', '<c-r>', '<cmd>Telescope resume<cr>',
    { desc = 'Resume the previous telescope search' })
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
  -- Find File
  vim.keymap.set('n', '<leader>fv', function()
    require('telescope.builtin').find_files({
      preview={hide_on_startup=true},
      cwd = '~/var',
      hidden = false,
    })
  end, { desc = 'Find var file' })
  -- Find Here (Buffer's dir is the CWD)
  vim.keymap.set('n', '<leader>fh', function()
    require('yashlala.telescope-custom').find_files_bufdir({
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
  -- File browser
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
    -- Find word in current buffer only
  vim.keymap.set('n', '<leader>fw', function()
    require('telescope.builtin').current_buffer_fuzzy_find({})
  end)

  -- LSP "goto" commands Keybinds
  vim.keymap.set('n', 'gd', function()
    if vim.tbl_isempty(vim.lsp.buf_get_clients()) then
      vim.cmd('normal! gd')
    else
      vim.lsp.buf.definition()
    end
  end,
    { desc = 'Go to definition' }
  )
  vim.keymap.set('n', 'gD', function()
    if vim.tbl_isempty(vim.lsp.buf_get_clients()) then
      vim.cmd('normal! gD')
    else
      vim.lsp.buf.declaration()
    end
  end,
    { desc = 'Go to declaration' }
  )
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition,
    { desc = 'Go to type definition' })

  -- "<leader>x" := "eXplore". These generally put useful things in quickfix list.
  vim.keymap.set('n', '<leader>x', '<nop>')
  vim.keymap.set('n', '<leader>xi', vim.lsp.buf.incoming_calls,
    { desc = 'Explore incoming calls to symbol'})
  vim.keymap.set('n', '<leader>xo', vim.lsp.buf.outgoing_calls,
    { desc = 'Explore outgoing calls from symbol'})
  vim.keymap.set('n', '<leader>xa', vim.lsp.buf.references,
    { desc = 'Explore all references to symbol' })
  vim.keymap.set('n', '<leader>xI', vim.lsp.buf.implementation,
    { desc = 'Explore implementations of interface'})
  vim.keymap.set('n', '<leader>xs', function()
      require('telescope.builtin').lsp_dynamic_workspace_symbols(
        { preview = { hide_on_startup = true }})
    end,
    { desc = 'Explore all symbols in the workspace' })
  vim.keymap.set('n', '<leader>xh', function()
      require('telescope.builtin').lsp_document_symbols()
    end,
    { desc = 'Explore all symbols here (buffer)' })
  vim.keymap.set('n', '<leader>xr', vim.lsp.buf.rename,
    { desc = 'Rename a symbol' })
  -- "Fix"; command defined in nvim-code-action-menu plugin.
  -- Put it in a wrapper because the command isn't defined at this point in
  -- initialization...
  vim.keymap.set('n', '<leader>xf', function() vim.cmd('CodeActionMenu') end,
    { desc = 'Fix problem via LSP actions' })
  vim.keymap.set('n', '<leader>xl', vim.lsp.codelens.run,
    { desc = 'Run CodeLens' })

  vim.keymap.set('n', '<bslash>', '<cmd>lua vim.lsp.buf.hover()<cr>',
    { desc = 'Info about symbol' })
  vim.keymap.set('n', '<bar>', '<cmd>lua vim.diagnostic.open_float()<cr>',
    { desc = 'Info about error'})

  -- Cmdline mode: make files easy
  vim.keymap.set('c', '<c-j>', '',
    { desc = 'Use shell "j"ao command to complete dir' })
end

return M
