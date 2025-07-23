require("peyton")

-- for nvim tree
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.opt.relativenumber = true
vim.opt.nu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir = os.getenv("MY_DEV_ENV.DOTFILES") .. "/undodir"
vim.opt.undofile = true

vim.opt.wrap = false

vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.scrolloff = 16
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "140"

vim.g.leader = " "

-- move things up and down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- append line below to current line with a space between
-- regardless of where your cursor is in the line
vim.keymap.set("n", "J", "mzJ`z")

-- set page up / down to keep you centered on screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- do the same for search, keep results in middle of screen when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- term splits
vim.keymap.set("n", "<leader>h", function() vim.cmd "split" end, { desc = "New horizontal split" })
vim.keymap.set("n", "<leader>v", function() vim.cmd "vsplit" end, { desc = "New vertical split" })
vim.keymap.set("n", "<leader>c", function() vim.cmd "close" end, { desc = "Close split" })

-- paste over and keep in buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

-- copy into system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- replace the word your cursor is over everywhere in file
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
