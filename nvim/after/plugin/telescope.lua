local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope find_files" })
vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = "Telescope resume" })
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Telescope live_grep" })
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set('n', '<leader>tg', builtin.current_buffer_fuzzy_find, { desc = "Telescope Current Buffer Fuzzy" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Telescope help_tags" })
vim.keymap.set('n', '<leader>tj', function() vim.cmd "Telescope jumplist" end, { desc = "Telescope jumplist" }) -- respects git ignore, only files in git
vim.keymap.set('n', '<leader>td', builtin.lsp_definitions, { desc = "Telescope definitions" })
vim.keymap.set('n', '<leader>tr', builtin.lsp_references, { desc = "Telescope references" })
vim.keymap.set('n', '<leader>ts', function() vim.cmd "Telescope lsp_document_symbols" end,
    { desc = "Telescope doc symbols" })
vim.keymap.set('n', '<leader>tm', function() vim.cmd "Telescope marks" end,
    { desc = "Telescope marks" })
vim.keymap.set('n', '<leader>tc', builtin.commands, { desc = "Telescope commands" })
vim.keymap.set('n', '<leader>tq', function() vim.cmd "Telescope colorscheme enable_preview=true" end,
    { desc = "Telescope colorscheme" })

local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
vim.keymap.set("n", "<leader>gd", live_grep_args_shortcuts.grep_word_under_cursor)


-- respects git ignore, only files in git
-- vim.keymap.set('n', '<leader>fr', builtin.git_files {})


-- Customize the preview window that pops up
-- vim.api.nvim_create_autocmd("User", {
--     pattern = "TelescopePreviewerLoaded",
--     callback = function(args)
--         vim.wo.number = true
--     end,
-- })
