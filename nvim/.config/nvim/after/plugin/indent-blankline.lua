require('indent_blankline').setup {
  char = '┊',
  use_treesitter = true,
  filetype_exclude = {
    'lspinfo',
    'text',
    'mail',
    'vimwiki',
    'markdown',
    'packer',
    'checkhealth',
    'help',
    'man',
    '',
  }
}
