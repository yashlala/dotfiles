require('ibl').setup {
  indent = { char = '┊', },
  exclude = {
    filetypes = {
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
}
