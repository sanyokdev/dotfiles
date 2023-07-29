-- Line numbers
vim.opt.number = true
-- vim.opt.relativenumber = true

-- Indentation & wrapping
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1
vim.opt.smarttab = true

vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.cindent = true

vim.opt.backspace = "indent,eol,start"

vim.opt.wrap = false

-- Cursor
vim.opt.cursorline = true
vim.opt.scrolloff = 4
vim.opt.updatetime = 100

-- Cmd & Search
vim.opt.showcmd = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.keymap.set("n", "<Esc>", ":noh<CR>")

-- Text & Clipboard
vim.opt.iskeyword:append("-")
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard

-- Window management
vim.opt.splitright = true
vim.opt.splitbelow = true
