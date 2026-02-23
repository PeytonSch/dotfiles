return {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        opts = {
            servers = {
                lua_ls = {},
            },
        },
        config = function(_, opts)
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            for server, config in pairs(opts.servers) do
                config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
                lspconfig[server].setup(config)
            end
        end,
    },
}
