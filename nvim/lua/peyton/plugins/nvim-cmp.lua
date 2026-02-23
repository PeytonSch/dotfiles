return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
        },
        opts = function(_, opts)
            local cmp = require("cmp")
            local types = require("cmp.types")

            local auto = {
                completion = {
                    autocomplete = { types.cmp.TriggerEvent.TextChanged }, -- popup as you type
                    keyword_length = 1,
                },
            }

            -- / and ? -> buffer completion
            cmp.setup.cmdline({ "/", "?" }, vim.tbl_deep_extend("force", auto, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = "buffer" } },
            }))

            -- : -> path + cmdline completion
            cmp.setup.cmdline(":", vim.tbl_deep_extend("force", auto, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
                }),
            }))

            return opts
        end,
    },
}
