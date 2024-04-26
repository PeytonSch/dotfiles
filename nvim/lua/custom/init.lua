-- local autocmd = vim.api.nvim_create_autocmd

vim.opt.relativenumber = true

-- these are recommended items from metals
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }
-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
