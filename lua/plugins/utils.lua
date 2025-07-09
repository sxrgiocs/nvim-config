return {
    -- Autopairs, self-explanatory
    'windwp/nvim-autopairs',

    -- Proper coloring of files
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require 'plugins.configs.treesitter'
        end,
    },

    -- Clipboard
    'ojroques/vim-oscyank',

    -- The swiss-knife of plugins
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require 'plugins.configs.telescope'
        end
    },

    -- Filetree
    {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require 'plugins.configs.nvimtree'
        end,
    },

    -- Signs for tracking Git files
    {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require 'plugins.configs.gitsigns'
        end,
    },
}
