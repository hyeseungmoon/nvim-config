-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.g.clipboard = {
  name = "osc52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = function()
      return { vim.fn.getreg('"'), vim.fn.getregtype('"') }
    end,
    ["*"] = function()
      return { vim.fn.getreg('"'), vim.fn.getregtype('"') }
    end,
  },
}

vim.keymap.set("i", "<C-c>", '<Esc>"+yyi', { noremap = true })
vim.keymap.set("n", "<C-c>", '<Esc>"+yy', { noremap = true })

vim.keymap.set("i", "<C-v>", "<Esc>pi", { noremap = true })
vim.keymap.set("n", "<C-v>", "p", { noremap = true })

vim.keymap.set("v", "<C-c>", '"+y', { noremap = true })

vim.keymap.set("n", "<C-z>", "u", { noremap = true })
vim.keymap.set("i", "<C-z>", "<Esc>ui", { noremap = true })

vim.keymap.set("n", "<C-_>", "gcc", { remap = true })
vim.keymap.set("v", "<C-_>", "gc", { remap = true })
vim.keymap.set("i", "<C-_>", "<Esc>gcci", { remap = true })

vim.opt.autowriteall = true

local group = vim.api.nvim_create_augroup("autosave", { clear = true })

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  group = group,
  callback = function()
    if vim.bo.modified then
      vim.cmd("silent write")
    end
  end,
})

require("overseer").setup()
