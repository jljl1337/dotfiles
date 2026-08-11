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
vim.opt.clipboard = "unnamedplus"

-- Syntax highlighting
vim.cmd("syntax on")

-- Vertical line for length marker
vim.opt.colorcolumn = "80"

-- Spelling check
vim.opt.spell = true
vim.opt.spelllang = { "en" }

-- Vertical split open on the right
vim.opt.splitright = true
