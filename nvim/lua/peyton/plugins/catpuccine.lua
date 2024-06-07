return {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		-- default setup
		require("catppuccin").setup()
		-- set theme 
		vim.cmd('colorscheme catppuccin-macchiato')
	end,
}
