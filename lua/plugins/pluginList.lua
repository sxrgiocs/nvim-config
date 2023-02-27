vim.cmd [[packadd packer.nvim]]

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua PackerSync
  augroup end
]])

-- call packer
local packer = require("packer")

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "single" }
        end,
        prompt_border = "single",
    },
    git = {
        clone_timeout = 600, -- Timeout, in seconds, for git clones
    },
    auto_clean = true,
    compile_on_sync = true,
    --    auto_reload_compiled = true
}

return packer.startup(function(use)
    use 'wbthomason/packer.nvim'

    -- lsp
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'onsails/lspkind-nvim',
    }

    -- Aesthetic plugins (bufferline, statusline...)
    use { 'akinsho/nvim-bufferline.lua' }
    use { 'NTBBloodbath/galaxyline.nvim' }
    use { 'kyazdani42/nvim-web-devicons' } -- icons used by galaxyline

    -- to show colors when they are RGB or HEX inside the file in the editor
    use { 'norcalli/nvim-colorizer.lua' }

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
    }

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzy-native.nvim' }
        },
    }

    -- nvimtree
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
    }

    -- ranger file manager implementation
    use {
        'francoiscabrol/ranger.vim',
        requires = {
            'rbgrouleff/bclose.vim'
        }
    }

    -- completion
    use {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip',
    }

    -- snippets
    use {
        'L3MON4D3/LuaSnip',
        after = 'nvim-cmp',
    }

    -- git
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
    }

    -- latex
    use {
        "lervag/vimtex",
        "conornewton/vim-latex-preview",
        ft = { "tex" }
    }

    -- daily usage
    use {
        'windwp/nvim-autopairs',
        'andymass/vim-matchup'
    }
end)
