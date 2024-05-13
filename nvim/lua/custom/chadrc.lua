---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "chadracula",
  theme_toggle = { "chadracula", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,
  statusline = {
    overriden_modules = function(modules)
      modules[2] = (function()
        local config = require("core.utils").load_config().ui.statusline
        local sep_style = config.separator_style

        local default_sep_icons = {
          default = { left = "", right = " " },
          round = { left = "", right = "" },
          block = { left = "█", right = "█" },
          arrow = { left = "", right = "" },
        }

        local separators = (type(sep_style) == "table" and sep_style) or default_sep_icons[sep_style]

        local sep_r = separators["right"]
        local icon = " 󰈚 "
        local name = vim.fn.expand("%:.")

        if name ~= "Empty " then
          local devicons_present, devicons = pcall(require, "nvim-web-devicons")

          if devicons_present then
            local ft_icon = devicons.get_icon(name)
            icon = (ft_icon ~= nil and " " .. ft_icon) or ""
          end

          name = " " .. name .. " "
        end

        return "%#St_file_info#" .. icon .. name .. "%#St_file_sep#" .. sep_r
      end)()
    end,
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
