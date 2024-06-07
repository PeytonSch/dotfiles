local opts = {
  git = {
    enable = true,
  },
  view = {
    width = 45,
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


return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup(opts)
  end,
}
