local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc="Telescope find_files"})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc="Telescope live_grep"})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc="Telescope buffers"})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc="Telescope help_tags"})
vim.keymap.set('n', '<leader>fj', function() vim.cmd "Telescope jumplist" end, {desc="Telescope jumplist"})-- respects git ignore, only files in git
vim.keymap.set('n', '<leader>td', builtin.lsp_definitions, {desc="Telescope definitions"})
vim.keymap.set('n', '<leader>tr', builtin.lsp_references, {desc="Telescope references"})
-- vim.keymap.set('n', '<leader>fr', builtin.git_files {})
