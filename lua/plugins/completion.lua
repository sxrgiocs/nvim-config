return {
    {
        'hrsh7th/nvim-cmp',
        config = function()
            require 'plugins.configs.cmp'
        end,
    },
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    {
        'L3MON4D3/LuaSnip',
        requires = {
            'rafamadriz/friendly-snippets'
        },
        config = function() require 'plugins.configs.luasnip' end
    }
}
