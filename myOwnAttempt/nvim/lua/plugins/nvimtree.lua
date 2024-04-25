-- options
local my_options = {
	git = {
		enable = true,
	},
	view = {
		width = 65,
		number = true,
		relativenumber = true,
		cursorline = true,
	},

	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}

local nvchad_options = {
	filters = {
		dotfiles = false,
	},
	disable_netrw = true,
	hijack_netrw = true,
	hijack_cursor = true,
	hijack_unnamed_buffer_when_opening = false,
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = false,
	},
	view = {
		adaptive_size = false,
		side = "left",
		width = 30,
		preserve_window_proportions = true,
	},
	git = {
		enable = true,
		ignore = true,
	},
	filesystem_watchers = {
		enable = true,
	},
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	renderer = {
		root_folder_label = false,
		highlight_git = true,
		highlight_opened_files = "none",

		indent_markers = {
			enable = true,
		},

		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},

			glyphs = {
				default = "󰈚",
				symlink = "",
				folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
					symlink_open = "",
					arrow_open = "",
					arrow_closed = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
}

-- overwrite equal values from the my_options table over the nvchad_options table
local options = vim.tbl_deep_extend("force", nvchad_options, my_options)

-- Lazy plugin spec
return {
	"nvim-tree/nvim-tree.lua",
	opts = options,
}
