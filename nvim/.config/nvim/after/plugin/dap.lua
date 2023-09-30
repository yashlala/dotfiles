require('dap-python').setup('/usr/bin/python3')

require('dapui').setup({})

-- continue (also start)
vim.keymap.set('n', '<leader>bc', require('dap').continue)
vim.keymap.set('n', '<leader>bn', require('dap').step_over)

-- gdb step
vim.keymap.set('n', '<leader>bs', require('dap').step_into)
vim.keymap.set('n', '<leader>bb', require('dap').toggle_breakpoint)
-- inspect
-- vim.keymap.set('n', '<leader>bi', require('dapui').toggle)


-- todo dapui eval etc
-- https://github.com/rcarriga/nvim-dap-ui
-- https://davelage.com/posts/nvim-dap-getting-started/
