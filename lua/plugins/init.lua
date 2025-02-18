-- lsp
require 'plugins.configs.lsp.lspconfig'
require 'plugins.configs.lsp.mason'
require 'plugins.configs.lsp.handlers'
require 'plugins.configs.lsp.lspkind'

-- aesthetic
require 'plugins.configs.bufferline'
require 'plugins.configs.statusline'
require 'plugins.configs.colorizer'

-- parser generator
require 'plugins.configs.treesitter'

-- File managers
require 'plugins.configs.telescope'
require 'plugins.configs.nvimtree'

-- completion
require 'plugins.configs.cmp'
require 'plugins.configs.copilot_lua'

-- snippets
require 'plugins.configs.luasnip'

-- git signs
require('gitsigns').setup()

-- autopairs
require('nvim-autopairs').setup()
