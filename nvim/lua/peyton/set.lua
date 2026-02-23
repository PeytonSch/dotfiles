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
vim.opt.undodir = "C:\\Users\\K160722\\Documents\\vim-undo-dir"
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
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- append line below to current line with a space between
-- regardless of where your cursor is in the line
vim.keymap.set("n", "J", "mzJ`z", { desc = "Append next line" })

-- format code block
vim.keymap.set("n", "<leader>=", "v%=%", { desc = "Format block" })

-- set page up / down to keep you centered on screen
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move Up" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move down" })

-- do the same for search, keep results in middle of screen when searching
vim.keymap.set("n", "n", "nzzzv", { desc = "Search forward" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search back" })

-- term splits
vim.keymap.set("n", "<leader>h", function() vim.cmd "split" end, { desc = "New horizontal split" })
vim.keymap.set("n", "<leader>v", function() vim.cmd "vsplit" end, { desc = "New vertical split" })
vim.keymap.set("n", "<leader>c", function() vim.cmd "close" end, { desc = "Close split" })

-- paste over and keep in buffer by default
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "past and keep in buffer" })
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "past and keep in buffer" })

-- copy into system clipboard
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "copy to system clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "copy to system clipboard" })

-- replace the word your cursor is over everywhere in file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word under cursor in file" })

-- toggle spellcheck
vim.keymap.set("n", "<leader>ws", function() vim.cmd "setlocal spell spelllang=en_us" end, { desc = "spellcheck on" })

-- select entire line from anywhere in line
-- lol this is just shift+v in vim
-- vim.keymap.set("n", "<leader>wv", "^v$", { desc = "select line" })

-- default colorscheme
-- vim.cmd[[colorscheme tokyonight-night]]

-- highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', {}),
    desc = 'Hightlight selection on yank',
    pattern = '*',
    callback = function()
        vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
    end,
})

vim.g.lazyvim_cmp = "nvim-cmp"
