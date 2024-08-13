-- set default colorscheme
vim.cmd [[colorscheme tokyonight-night]]
-- set lualine theme
require('lualine').setup {
    options = {
        -- ... your lualine config
        theme = 'tokyonight-night',
        -- theme = 'cyberdream'
        -- theme = 'pastelnight'
        -- theme = 'sorbet'
        -- ... your lualine config
    }
}
