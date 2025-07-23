-- local lsp_zero = require('lsp-zero')
--
-- lsp_zero.on_attach(function(client, bufnr)
--     -- print("Client Attaching")
--     -- see :help lsp-zero-keybindings
--     -- to learn the available actions
--     lsp_zero.default_keymaps({ buffer = bufnr })
--     vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "definition" })
--     vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "hover" })
--     vim.keymap.set("n", "<leader>gws", function() vim.lsp.buf.workspace_symbol() end, { desc = "symbols" })
--     vim.keymap.set("n", "<leader>gf", function() vim.diagnostic.open_float() end, { desc = "next diagnostic" })
--     vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, { desc = "diagnostic next" })
--     vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, { desc = "diagnostic prev" })
--     vim.keymap.set("n", "<leader>gca", function() require("tiny-code-action").code_action() end,
--         { desc = "tiny code action" })
--     vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, { desc = "references" })
--     vim.keymap.set("n", "<leader>gn", function() vim.lsp.buf.rename() end, { desc = "rename" })
--     vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, { desc = "signature_help" })
-- end)

-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        "lua_ls",
        "html",
        "cssls",
        "ts_ls",
        "pyright",
        "tailwindcss",
        -- "terraform_lsp", --throwing errors atm
        -- "java_language_server",
        "jdtls",
        "jsonls",
        -- "eslint-lsp",
        -- "prettierd", --installed manually, didnt like for some reason?
    },
    -- default handler for all language servers
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,

        -- specific handler for jdtls
        -- jdtls = function()
        --     print("Jdtls starting")
        --     local config = {
        --         cmd = {'/home/schepe2/.local/share/nvim/mason/packages/jdtls/bin/jdtls'},
        --         root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
        --     }
        --     require('jdtls').start_or_attach(config)
        -- end,
    },
})
