local present, _ = pcall(require, "plugins.packerInit")
local packer

vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

if present then
    packer = require "packer"
else
    return false
end

local use = packer.use

return packer.startup(
    function()

        use "wbthomason/packer.nvim"

        -- Colors
        use {
            "norcalli/nvim-colorizer.lua",
            config = function()
                require("plugins.configs.colorizer")
            end
        }

        -- Aesthetic plugins (bufferline, statusline...)
        use {
            "akinsho/nvim-bufferline.lua",
            config = function()
                require "plugins.configs.bufferline"
            end
        }

        use {
            "NTBBloodbath/galaxyline.nvim",
            config = function()
                require "plugins.configs.statusline"
            end
        }

        use {
            "kyazdani42/nvim-web-devicons",
            config = function()
            require "plugins.configs.icons"
            end
        }

        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = function()
                require "plugins.configs.treesitter"
            end
        }

        -- File exploring
        use {
            'nvim-telescope/telescope.nvim',
            requires = {
                {'nvim-lua/plenary.nvim'},
                {"nvim-telescope/telescope-fzy-native.nvim"}
            },
            config = function()
                require "plugins.configs.telescope"
            end,
        }

        use {
            "kyazdani42/nvim-tree.lua",
            cmd = "NvimTreeToggle",
            config = function()
                require "plugins.configs.nvimtree"
            end
        }

        use {
            "francoiscabrol/ranger.vim",
            requires = {
                "rbgrouleff/bclose.vim"
            }
        }

        --LSP
        use {
            "williamboman/mason.nvim",
            event = "BufRead",
        }

        use {
            "williamboman/mason-lspconfig.nvim",
        }

        use {
            "neovim/nvim-lspconfig",
            after = "mason.nvim",
            config = function()
                require "plugins.configs.lsp.lspconfig"
            end,
        }

        use {
            "onsails/lspkind-nvim",
            config = function()
                require("plugins.configs.lsp.lspkind")
            end
        }

        use {
            'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
        }

        -- Completion and snippets
        use {
            "hrsh7th/nvim-cmp",
            config = function()
                require "plugins.configs.cmp"
            end,
        }

        use {
            "L3MON4D3/LuaSnip",
            after = "nvim-cmp",
            config = function()
                require("plugins.configs.luasnip")
            end,
        }

        use {
            "saadparwaiz1/cmp_luasnip",
        }

        use {
            "hrsh7th/cmp-nvim-lua",
        }

        use {
            "hrsh7th/cmp-nvim-lsp",
        }

        use {
            "hrsh7th/cmp-buffer",
        }

        -- Git plugins
        use {
            'lewis6991/gitsigns.nvim',
            requires = {
            'nvim-lua/plenary.nvim'
            },
            config = function()
                require('gitsigns').setup()
            end,
        }

        -- LaTeX
        use {
            "lervag/vimtex",
            ft = {"tex"}
        }

        use {
            "conornewton/vim-latex-preview",
            ft = {"tex"}
        }

        -- Misc
        use {
            "windwp/nvim-autopairs",
            config = function()
                require "plugins.configs.autopairs"
            end,
        }

        use {
            "andymass/vim-matchup",
        }

        --use {
        --    "lukas-reineke/indent-blankline.nvim",
        --}

        use {
            "glepnir/dashboard-nvim",
            cmd = {
                "Dashboard",
                "DashboardNewFile",
                "DashboardJumpMarks",
                "SessionLoad",
                "SessionSave",
            },
            config = function()
                require "plugins.configs.dashboard"
            end,
        }
    end
)


