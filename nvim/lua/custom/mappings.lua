---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

-- example of mapping a function with require
-- {
--   function()
--     require("nvterm.terminal").new "horizontal"
--   end,
--   "New horizontal term",
-- }

M.customMappings = {
  -- normal mode
  n = {
    ["<leader>rt"] = { ":Telescope fd <CR>", "Telescope files" },
    ["<leader>rr"] = { ":Telescope live_grep <CR>", "Telescope live_grep" },

    ["<leader>tr"] = { ":Telescope lsp_references <CR>", "Telescope lsp_references" },
    ["<leader>td"] = { ":Telescope lsp_definitions <CR>", "lsp_definitions" },
    ["<leader>ti"] = { ":Telescope lsp_implementations <CR>", "lsp_implementations" },
    ["<leader>tc"] = { ":Telescope lsp_incoming_calls <CR>", "lsp_incoming_calls" },
    ["<leader>to"] = { ":Telescope lsp_outgoing_calls <CR>", "lsp_outgoing_calls" },
    ["<leader>ts"] = { ":Telescope lsp_document_symbols <CR>", "lsp_document_symbols" },
    ["<leader>tt"] = { ":Telescope lsp_type_definitions <CR>", "lsp_type_definitions" },
    ["<leader>tw"] = { ":Telescope lsp_workspace_symbols <CR>", "lsp_workspace_symbols" },
    ["<leader>tf"] = { ":Telescope lsp_document_symbols <CR>", "lsp_document_symbols" },
    ["<leader>tq"] = { ":Telescope lsp_dynamic_workspace_symbols <CR>", "lsp_dynamic_workspace_symbols" },
    ["<leader>gf"] = {
      function()
        require("grapple").toggle()
      end,
    },
    ["<leader>gg"] = {
      function()
        require("grapple").toggle_tags()
      end,
    },
    -- metals
    ["<leader>mc"] = {
      function()
        require("telescope").extensions.metals.commands()
      end,
      "Metals Commands",
    },
  },
  -- i = {
  --
  -- }
}

-- more keybinds!

return M
