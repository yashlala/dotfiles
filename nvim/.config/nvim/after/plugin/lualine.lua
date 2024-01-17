require'lualine'.setup {
  options = {
    icons_enabled = false,
    theme = 'zenbones',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {{
      'filename',
      path = 3 -- Absolute path, with tilde as the home directory
    }},
    lualine_c = {{
      function()
        local abs_cwd = vim.fn.getcwd()
        local abs_home = vim.fn.expand('~')
        return string.gsub(abs_cwd, abs_home, '~')
      end
    }},
    lualine_x = {'branch', 'filetype'},
    lualine_y = {'diagnostics'},
    lualine_z = {'location'},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {{
      'tabs',
      show_modified_status = false,
    }},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = {
    'quickfix',
    'fugitive',
    'fzf',
    'toggleterm',
  }
}
