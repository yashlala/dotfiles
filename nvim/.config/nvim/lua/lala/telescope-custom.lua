local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local action_set = require "telescope.actions.set"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"
local previewers = require "telescope.previewers"
local sorters = require "telescope.sorters"
local utils = require "telescope.utils"
local conf = require("telescope.config").values
local log = require "telescope.log"

local scan = require "plenary.scandir"
local Path = require "plenary.path"
local os_sep = Path.path.sep

local flatten = vim.tbl_flatten
local filter = vim.tbl_filter


local M = {}

--[[ Helper Functions ]]

local is_dir = function(value)
  return value:sub(-1, -1) == os_sep
end

local create_new_file = function(opts, prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local file = action_state.get_current_line()
  if file == "" then
    print(
      "To create a new file or directory(add "
        .. os_sep
        .. " at the end of file) "
        .. "write the desired name into the prompt and press <cr>. "
        .. "It works like `mkdir -p`, too. "
        .. "Example: this"
        .. os_sep
        .. "is"
        .. os_sep
        .. "a"
        .. os_sep
        .. "new_file.lua"
    )
    return
  end

  -- TODO: This doesn't work when we run it from a terminal window.
  -- Instead, maybe use
  -- local fpath = require('telescope.utils').buffer_dir())
  local fpath = current_picker.cwd .. os_sep .. file

  if not is_dir(fpath) then
    actions.close(prompt_bufnr)
    Path:new(fpath):touch { parents = true }
    vim.cmd(string.format(":edit %s", fpath))
  else
    Path:new(fpath:sub(1, -2)):mkdir { parents = true }
    local new_cwd = vim.fn.expand(fpath)
    -- Change the window's CWD.
    vim.cmd(string.format(":lcd %s", fpath))
    current_picker.cwd = new_cwd
  end
end

-- Find files, using the current buffer's path as the root dir.
-- Like if we were using autochdir!
M.find_files_bufdir = function(args)
  -- We want to use a keybind to toggle previews. We can't toggle previews of
  -- the current window, but we _can_ spawn a new Telescope window with the
  -- other option.
  -- Maintain two sets of options. Each has a keybind to invoke the other.
  -- We generate these sets via the gen_mappings wrapper function.
  local gen_mappings = function(opts, alternate_opts)
    return function(prompt_bufnr, map)
      -- Toggle the preview window as described above.
      map("i", "<M-p>", function()
        actions.close(prompt_bufnr)
        vim.schedule(function()
          require("telescope.builtin").find_files(alternate_opts)
        end)
      end)

      -- Visit the given file. If it doesn't exist, then create it.
      map('i', '<cr>', function(prompt_bufnr)
        create_new_file(opts, prompt_bufnr)
      end)

      return true
    end
  end

  local opts_with_preview, opts_without_preview
  local preview_mappings = gen_mappings(opts_with_preview,
      opts_without_preview)
  local without_preview_mappings = gen_mappings(
      opts_without_preview, opts_with_preview)

  opts_with_preview = {
    prompt_title = "Find Files in Buffer Dir",
    shorten_path = false,
    -- TODO: Use the proper path.
    cwd = vim.fn.expand('%:h'),
    attach_mappings = preview_mappings,
  }
  vim.tbl_extend('keep', opts_with_preview, args)

  opts_without_preview = vim.deepcopy(opts_with_preview)
  opts_without_preview.previewer = false
  opts_without_preview.attach_mappings = without_preview_mappings

  require("telescope.builtin").find_files(opts_with_preview)
end

return M
