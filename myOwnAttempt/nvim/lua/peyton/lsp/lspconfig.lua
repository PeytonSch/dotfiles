local on_attach = require("peyton.lsp.functions").on_attach
local capabilities = require("peyton.lsp.functions").capabilities

-- NOTE TO PEYTON LATER TODAY, I AM TRYING TO MOVE THESE MASON THINGS OVER TO MY NEW CONFIG
-- important for mason-lspconfig that these are done before loading plugins
require("mason").setup()
require("mason-lspconfig").setup()

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "pyright", "tflint", "lua_ls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- require'lspconfig'.lua_ls.setup{}
