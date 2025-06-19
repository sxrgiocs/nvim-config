-- lspconfig.lua

-- Mappings
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- on_attach function
local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<space>k', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

    vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format()
        end
    })
end

-- Shared config
local lsp_config = {
    on_attach = on_attach
}

-- Import per-server configs
local pylsp_config = require("plugins.configs.lsp.servers.pylsp")
local lua_ls_config = require("plugins.configs.lsp.servers.lua_ls")
local bashls_config = require("plugins.configs.lsp.servers.bashls")

-- Mason + lspconfig integration
require('mason-lspconfig').setup({
    ensure_installed = { "pylsp", "lua_ls", "bashls" },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,

        ["pylsp"] = function()
            require('lspconfig').pylsp.setup(pylsp_config)
        end,

        ["lua_ls"] = function()
            require('lspconfig').lua_ls.setup(lua_ls_config)
        end,

        ["bashls"] = function()
            require('lspconfig').bashls.setup(bashls_config)
        end,
    }
})

return lsp_config
