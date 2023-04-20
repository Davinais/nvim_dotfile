-- utf-8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = 'utf-8'

-- Enable mouse
vim.o.mouse = "a"

-- Line cursor and number
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true

-- Indent
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true

-- Change split behavior
vim.o.splitbelow = true
vim.o.splitright = true

-- Color configuration
vim.o.background = "dark"
vim.o.termguicolors = true

-- Disable showmode since there's lualine
vim.o.showmode = false
-- Change cmdheight to avoid hit-enter
vim.o.cmdheight = 2

-- Always show tabline
vim.o.showtabline = 2
