return {
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {
      -- Keep it aligned with your timeoutlen (default behavior in the plugin)
      timeout = vim.o.timeoutlen,

      -- If you ONLY want jk (and not jj, etc.), disable defaults:
      default_mappings = false,

      -- Map: Insert mode: j then k => <Esc>
      mappings = {
        i = {
          j = {
            k = "<Esc>",
          },
        },
      },
    },
  },
}
