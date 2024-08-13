return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
        {
            'nvim-lua/plenary.nvim'
        },
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
            -- This will not install any breaking changes.
            -- For major updates, this must be adjusted manually.
            version = "^1.0.0",
        },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require "telescope.actions"
        local lga_actions = require("telescope-live-grep-args.actions")
        -- first setup telescope
        telescope.setup({
            -- your config

            extensions = {
                live_grep_args = {
                    auto_quoting = true, -- enable/disable auto-quoting
                    -- define mappings, e.g.
                    mappings = {         -- extend mappings
                        i = {
                            ["<C-k>"] = lga_actions.quote_prompt(),
                            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob **/" }),
                            ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t " }),
                            -- freeze the current list and start a fuzzy search in the frozen list
                            ["<C-f>"] = actions.to_fuzzy_refine,
                        },
                    },
                    -- ... also accepts theme settings, for example:
                    -- theme = "dropdown", -- use dropdown theme
                    -- theme = { }, -- use own theme spec
                    -- layout_config = { mirror=true }, -- mirror preview pane
                }
            }
        })

        -- then load the extension
        telescope.load_extension("live_grep_args")
    end
}
