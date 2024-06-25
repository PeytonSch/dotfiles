local config = {
    cmd = {'/home/schepe2/.local/share/nvim/mason/packages/jdtls/bin/jdtls'},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),

    -- allows for completion of functions and auto importing
    capabilities = {
        workspace = {
            configuration = true,
        },
        textDocument = {
            completion = {
                completionItem = {
                    snippentSupport = true,
                },
            },
        },
    },
}
print("jdtls starting from ftplugin")
config.capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
require('jdtls').start_or_attach(config)

vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, {desc="definition"})
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, {desc="hover"})
vim.keymap.set("n", "<leader>gws", function() vim.lsp.buf.workspace_symbol() end, {desc="symbols"})
vim.keymap.set("n", "<leader>gf", function() vim.diagnostic.open_float() end, {desc="next diagnostic"})
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, {desc="diagnostic next"})
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, {desc="diagnostic prev"})
vim.keymap.set("n", "<leader>q", function() vim.lsp.buf.code_action() end, {desc="code action"})
vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, {desc="references"})
vim.keymap.set("n", "<leader>gn", function() vim.lsp.buf.rename() end, {desc="rename"})
vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, {desc="signature_help"})



