return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup {
            -- https://github.com/nvim-lualine/lualine.nvim?tab=readme-ov-file#filename-component-options
            sections = {
                -- lualine_a = { 'mode' },
                -- lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = {
                    {
                        'filename',
                        file_status = true,    -- Displays file status (readonly status, modified status)
                        newfile_status = true, -- Display new file status (new file means no write after created)
                        path = 1,              -- relative path
                        icons_enabled = true,
                    }
                },
                -- lualine_x = { 'encoding', 'fileformat', 'filetype' },
                -- lualine_y = { 'progress' },
                -- lualine_z = { 'location' }

            }
        }
    end,
}
