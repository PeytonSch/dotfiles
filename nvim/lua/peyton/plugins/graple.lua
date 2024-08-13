return {
    "cbochs/grapple.nvim",
    opts = {
        scope = "git", -- also try out "git_branch"
        icons = true,  -- setting to "true" requires "nvim-web-devicons"
        status = false,
        style = "basename",
    },
    keys = {
        { "<leader>a", "<cmd>Grapple tag<cr>",                      desc = "Tag a file" },
        -- { "<leader>d", "<cmd>Grapple untag<cr>",                    desc = "Untag a file" },
        { "<leader>T", "<cmd>Grapple toggle scope=global<cr>",      desc = "Tag a file globally" },
        { "<c-e>",     "<cmd>Grapple toggle_tags<cr>",              desc = "Toggle tags menu" },
        { "<c-w>",     "<cmd>Grapple toggle_tags scope=global<cr>", desc = "Toggle tags menu" },

        { "<leader>j", "<cmd>Grapple select index=1<cr>",           desc = "Select first tag" },
        { "<leader>h", "<cmd>Grapple select index=2<cr>",           desc = "Select second tag" },
        { "<leader>k", "<cmd>Grapple select index=3<cr>",           desc = "Select third tag" },
        { "<leader>l", "<cmd>Grapple select index=4<cr>",           desc = "Select fourth tag" },

        { "<c-s-n>",   "<cmd>Grapple cycle_tags next<cr>",          desc = "Go to next tag" },
        { "<c-s-p>",   "<cmd>Grapple cycle_tags prev<cr>",          desc = "Go to previous tag" },
    },
    ---Additional window options for Grapple windows
    ---See :h nvim_open_win
    ---@type grapple.vim.win_opts
    win_opts = {
        -- Can be fractional
        width = 80,
        height = 20,
        row = 0.5,
        col = 0.5,

        relative = "editor",
        border = "single",
        focusable = false,
        style = "minimal",
        title_pos = "center",

        -- Custom: fallback title for Grapple windows
        title = "Grapple",

        -- Custom: adds padding around window title
        title_padding = " ",
    }
}
