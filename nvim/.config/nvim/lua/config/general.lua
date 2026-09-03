-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Wrapping
vim.opt.wrap = false

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Copy and paste from or to system clipboard
local function local_paste()
  return { vim.fn.split(vim.fn.getreg('"'), "\n"), vim.fn.getregtype('"') }
end

vim.g.clipboard = {
  name = "OSC52 (write-only)",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = local_paste,
    ["*"] = local_paste,
  },
}

vim.opt.clipboard = "unnamedplus"

-- Syntax highlighting
vim.cmd("syntax on")

-- Vertical line for length marker
vim.opt.colorcolumn = "80"

-- Vertical split open on the right
vim.opt.splitright = true
