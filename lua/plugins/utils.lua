return {
    -- Autopairs, self-explanatory
    'windwp/nvim-autopairs',

    -- Clipboard
    'ojroques/vim-oscyank',

    -- File icons for filetypes
    'nvim-tree/nvim-web-devicons',

    -- The swiss-knife of plugins
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require 'plugins.configs.telescope'
        end
    },

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require 'plugins.configs.snacks'
        end
    },

    -- Signs for tracking Git files
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require 'plugins.configs.gitsigns'
        end,
    },

    {
        'nvim-telescope/telescope.nvim',
        version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- optional but recommended
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        }
    }
}
