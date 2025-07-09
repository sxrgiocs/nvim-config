return {
    -- Bufferline
    {
        'willothy/nvim-cokeline',
        dependencies = {
            'nvim-lua/plenary.nvim',       -- Required for v0.4.0+
            'nvim-tree/nvim-web-devicons', -- If you want devicons
            'stevearc/resession.nvim'      -- Optional, for persistent history
        },
        config = function()
            require 'plugins.configs.cokeline'
        end
    },

    -- Statusline
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require 'plugins.configs.lualine'
        end,
    },

    -- to show colors when they are RGB or HEX inside the file in the editor
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require 'plugins.configs.colorizer'
        end,
    }
}
