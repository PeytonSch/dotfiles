local function comment()
	require("Comment.api").toggle.linewise.current()
end

return {
	'numToStr/Comment.nvim',
	opts = {
		-- add any options here
	},
	lazy = false,
	config = function()
		require("Comment").setup()
		-- call the local function above inline to cal l the comment api
		vim.keymap.set('n', '<leader>/', comment, {desc="Comment"})
		vim.keymap.set('v', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", {desc="Comment"})

	end
}

