vim.keymap.set("n", "<leader>pb", ":Telescope file_browser<CR>", { desc = "Telescope File Browser" })

-- open file_browser with the path of the current buffer
vim.keymap.set("n", "<leader>pv", ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
    { desc = "Telescope File Browser at dir" })
