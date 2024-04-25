-- This is the module that Lazy looks to for a plugin spec, as opposed to passing plugins in as a table directly.
-- All other top level sub modules will be merged together in the final spec.

-- plugin spec can be found here:
-- https://github.com/folke/lazy.nvim?tab=readme-ov-file#-plugin-spec
return {

	{
		"j-hui/fidget.nvim",
	},

	-- important to load lspconfig after this
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("peyton.lsp.functions")
			require("peyton.lsp.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
	},

	{
		"nvim-tree/nvim-web-devicons",
	},
}
