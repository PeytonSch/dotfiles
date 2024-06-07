local harpoon = require('harpoon')
harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	local make_finder = function()
		-- print("Making finder")
		local paths = {}
		for _, item in ipairs(harpoon_files.items) do
			table.insert(paths, item.value)
		end

		return require("telescope.finders").new_table(
		{
			results = paths
		}
		)
	end

	require("telescope.pickers").new(
	{},
	{
		prompt_title = "Harpoon",
		finder = make_finder(),
		previewer = conf.file_previewer({}),
		sorter = conf.generic_sorter({}),
		attach_mappings = function(prompt_buffer_number, map)
			map(
			"n",
			"<C-d>", -- your mapping here
			function()
				local state = require("telescope.actions.state")
				local selected_entry = state.get_selected_entry()
				local current_picker = state.get_current_picker(prompt_buffer_number)
				-- print("Selected entry", selected_entry.index)
				harpoon:list():remove_at(selected_entry.index)
				current_picker:refresh(make_finder())
			end
			)

			return true
		end
	}
	):find()
end

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
{ desc = "Open harpoon window" })

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, {desc="Harpoon Add"} )
vim.keymap.set("n", "<leader>d", function() harpoon:list():remove() end, {desc="Harpoon Remove"} )
-- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>j", function() harpoon:list():select(1) end, {desc="Harpoon 1"} )
vim.keymap.set("n", "<leader>k", function() harpoon:list():select(2) end, {desc="Harpoon 2"} )
vim.keymap.set("n", "<leader>l", function() harpoon:list():select(3) end, {desc="Harpoon 3"} )
vim.keymap.set("n", "<leader>h", function() harpoon:list():select(4) end, {desc="Harpoon 4"} )

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-n>", function() harpoon:list():prev() end, {desc="Harpoon last"} )
vim.keymap.set("n", "<C-b>", function() harpoon:list():next() end, {desc="Harpoon next"} )





