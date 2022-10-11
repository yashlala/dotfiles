local M = {}

M.setup = function()
  if not pcall(require, "packer") then
    print "Downloading packer.nvim..."

    local packer_dir = string.format("%s/site/pack/packer/start/",
      vim.fn.stdpath("data"))
    vim.fn.mkdir(packer_dir, 'p')

    local out = vim.fn.system(string.format("git clone %s %s",
        "https://github.com/wbthomason/packer.nvim",
        packer_dir .. "/packer.nvim"))
    print(out)

    vim.fn.input("Exiting now, you'll need to restart. Press <CR> to continue.")
    vim.cmd('quitall!')
  end
end

return M
