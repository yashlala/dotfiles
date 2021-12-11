vim.api.nvim_set_var('lightline#bufferline#unnamed', '[No Name]')
vim.api.nvim_exec([[
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ ['buffers'] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ],
      \     [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_expand': { 'buffers': 'lightline#bufferline#buffers' },
      \ 'component_type': { 'buffers': 'tabsel' } }
]], false)
