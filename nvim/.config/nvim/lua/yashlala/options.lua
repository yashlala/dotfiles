-- Basic Vim options.
local M = {}

-- TODO: add splitkeep once its merged in. 

M.setup = function()
  vim.o.confirm = true -- Ask before dangerous changes
  vim.o.gdefault = true -- s/.../.../g by default. Might break plugins.
  vim.o.timeout = false -- Don't delay when given ambiguous keymaps

  vim.o.autoindent = true -- use line's indent for the next line
  vim.o.smartindent = true; -- and use C rules if possible.

  vim.o.ignorecase = true -- Ignore case when searching (use \C to undo)
  vim.o.smartcase = true -- unless we see a capital letter

  -- TODO: We briefly got a ballin fold thing going.
  -- Now that we have treesitter, this could become a real game changer in
  -- terms of quickly parsing code.
  vim.o.foldenable = true
  vim.o.foldlevelstart = 99 -- Start with no folds closed.
  -- Use treesitter for folds
  vim.o.foldmethod = 'expr'
  vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

  -- Use ripgrep for `:grep`, if it's available
  if vim.fn.executable('rg') == 1 then
    vim.o.grepprg = 'rg --vimgrep --no-heading $*'
    vim.o.grepformat = '%f:%l:%c:%m,%f:%l:%m'
  end
  -- Use interactive Z shell (to include aliases)
  if vim.fn.executable('zsh') == 1 then
    vim.o.shell = 'zsh'
    vim.o.shellcmdflag = '-i -c'
    vim.o.shellredir = '>%s 2>&1'
  end
  vim.o.tagfunc = 'v:lua.vim.lsp.tagfunc'
  vim.o.cscopetag = true -- <c-]> should try cscope first instead of ctags
  vim.o.cscopequickfix = 's-,g-,d-,c-,t-,e-,f-,i-,a-' -- cscope should use the qflist

  vim.o.wrap = true
  vim.o.breakindent = true -- A line's wrap should be indented the same
  vim.o.showbreak = '↳' -- Display arrow symbol for wrapped lines
  vim.o.linebreak = true

  vim.o.belloff = 'all'  -- No bells! Whistles are OK.
  vim.o.undofile = true -- persistent undo between sessions
  vim.o.scrollback = 8192 -- lines of terminal mode scrollback
  vim.o.updatetime = 3000

  vim.o.lazyredraw = true
  vim.o.hlsearch = false
  vim.o.termguicolors = true

  vim.o.signcolumn = 'yes' -- Always show the sign column.
  vim.o.pumheight = 6 -- Limit the number of completion popup menu options.
  vim.o.modeline = true
  vim.o.showmode = false -- Don't write VISUAL on the last line.
  vim.o.laststatus = 3 -- One global statusline. 

  vim.o.equalalways = false
  vim.o.splitright = true
  vim.o.splitbelow = false

  vim.o.mouse = 'a'

  vim.opt.jumpoptions:append('stack')
  -- Ordinarily, "cw" and "cW" are treated like "ce" and "cE" if the cursor is
  -- on a non-blank.  This is Vi-compatible, but confusing. Make it consistent. 
  vim.opt.cpoptions:remove('_')
end

return M
