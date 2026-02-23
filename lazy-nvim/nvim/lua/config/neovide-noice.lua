return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      if vim.g.neovide then
        -- these map to ext_cmdline/ext_messages/ext_popupmenu behavior
        opts.cmdline = vim.tbl_deep_extend("force", opts.cmdline or {}, { enabled = false })
        opts.messages = vim.tbl_deep_extend("force", opts.messages or {}, { enabled = false })
        opts.popupmenu = vim.tbl_deep_extend("force", opts.popupmenu or {}, { enabled = false })

        -- Keep Noice's LSP markdown enhancements if you want (usually safe):
        -- opts.lsp = opts.lsp or {}
      end
    end,
  },
}
