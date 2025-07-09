return {
    {
        'williamboman/mason.nvim',
        config = function()
            require 'plugins.configs.lsp.mason'
        end,
    },
    'williamboman/mason-lspconfig.nvim',
    {
        'neovim/nvim-lspconfig',
        config = function()
            require 'plugins.configs.lsp.lspconfig'
        end,
    },
    'onsails/lspkind-nvim',

}
