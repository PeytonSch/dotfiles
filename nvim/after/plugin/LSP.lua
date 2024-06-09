local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, {desc="definition"})
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, {desc="hover"})
    vim.keymap.set("n", "<leader>gws", function() vim.lsp.buf.workspace_symbol() end, {desc="symbols"})
    vim.keymap.set("n", "<leader>gf", function() vim.diagnostic.open_float() end, {desc="next diagnostic"})
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, {desc="diagnostic next"})
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, {desc="diagnostic prev"})
    vim.keymap.set("n", "<leader>gca", function() vim.lsp.buf.code_action() end, {desc="code action"})
    vim.keymap.set("n", "<leader>grr", function() vim.lsp.buf.references() end, {desc="references"})
    vim.keymap.set("n", "<leader>grn", function() vim.lsp.buf.rename() end, {desc="rename"})
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, {desc="signature_help"})
end)

-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		"lua_ls",
		"html",
		"cssls",
		"tsserver",
		"pyright",
		"tailwindcss",
		-- "terraform_lsp", --throwing errors atm 
		"java_language_server",
	},
	-- default handler for all language servers
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	},
})
