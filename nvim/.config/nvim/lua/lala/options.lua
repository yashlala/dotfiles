-- Basic Vim options. 

local M = function() 
  vim.o.confirm = true -- Ask before dangerous changes
  vim.o.gdefault = true -- s/.../.../g by default

  vim.o.autochdir = true -- CWD should follow current buffer

  vim.o.autoindent = true -- use line's indent for the next line
  vim.o.smartindent = true; -- and use C rules if possible.

  vim.o.ignorecase = true -- Ignore case when searching (use \C to undo)
  vim.o.smartcase = true -- unless we see a capital letter

  -- Use treesitter for folds
  vim.o.foldmethod = 'expr'
  vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

  vim.o.wrap = true
  vim.o.breakindent = true -- A line's wrap should be indented the same
  vim.o.showbreak = '    ' -- 4 extra spaces before wrapped line starts
  vim.o.linebreak = true

  vim.o.belloff = 'all'  -- No bells! Whistles are OK. 

  -- TODO: We briefly got a ballin fold thing going. 
  -- Now that we have treesitter, this could become a real game changer in
  -- terms of quickly parsing code. 
  vim.o.foldenable = true
  vim.o.foldlevelstart = 99 -- Start with no folds closed. 

  vim.o.hidden = true -- buffers don't disappear the moment you switch away

  vim.o.undofile = true -- persistent undo between sessions

  vim.o.lazyredraw = true
  vim.o.hlsearch = false
  vim.o.termguicolors = false -- TODO: Was this causing highlight problems? 

  vim.o.modeline = true
  vim.o.showmode = false -- Don't write VISUAL on the last line. 

  vim.o.mouse = 'a'

  vim.o.scrollback = 8192 -- lines of terminal mode scrollback

  -- TODO: Add documentation for this. 
  -- There should highkey be a better option here, this is dumb. 
  -- We removed the `_` option. 
  -- vim.o.cpoptions = 'aABceFs'
  -- We can use the below to  delete options!
  vim.o.cpoptions = vim.o.cpoptions:gsub("_", "")

  -- TODO: Figure this out. 
  --[[ vim.o.formatoptions = vim.o.formatoptions
    - "a" -- Auto formatting is BAD.
    - "t" -- Don't auto format my code. I got linters for that.
    + "c" -- In general, I like it when comments respect textwidth
    + "q" -- Allow formatting comments w/ gq
    - "o" -- O and o shouldn't continue comments -- we have Commentary.nvim
    + "r" -- but we _should_ continue when pressing enter.
    + "n" -- Indent past the formatlistpat, not underneath it.
    + "j" -- Auto-remove comments if possible.
    - "2" -- We don't indent the first line of paragraphs anymore. ]]
end

return M
