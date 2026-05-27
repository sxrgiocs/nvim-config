-- Native LSP configuration

local function on_attach(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<space>k', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)

    -- Auto-format on save
    vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function() vim.lsp.buf.format() end,
    })
end

-- CMP completion capabilities (Optional, falls back gracefully)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
    capabilities = cmp_lsp.default_capabilities(capabilities)
end

-- Root directory resolvers
local function get_pylsp_root()
    local match = vim.fs.find(
        { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
        { upward = true, path = vim.fn.expand('%:p:h') }
    )[1]
    return match and vim.fs.dirname(match) or vim.fn.getcwd()
end

local function get_lua_root()
    local match = vim.fs.find(
        { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
        { upward = true, path = vim.fn.expand('%:p:h') }
    )[1]
    return match and vim.fs.dirname(match) or vim.fn.getcwd()
end

-- Python setup (pylsp)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.lsp.start({
            name = 'pylsp',
            cmd = { 'pylsp' },
            root_dir = get_pylsp_root(),
            settings = {
                pylsp = {
                    plugins = {
                        pycodestyle = {
                            enabled = true,
                            ignore = { "W391", "E501" },
                            maxLineLength = 200,
                        },
                    },
                },
            },
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
})

-- Lua setup (lua-language-server)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function()
        vim.lsp.start({
            name = 'lua_ls',
            cmd = { 'lua-language-server' },
            root_dir = get_lua_root(),
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    telemetry = { enable = false },
                },
            },
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
})

-- Diagnostics Config
vim.diagnostic.config({
    virtual_text = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.INFO]  = "",
            [vim.diagnostic.severity.HINT]  = "󰌵",
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "single",
        source = true,
        header = "",
        prefix = "[lsp] ",
    },
})

if not vim.notify_orig then
    vim.notify_orig = vim.notify
    vim.notify = function(msg, level, opts)
        if msg:match("exit code") then return end
        vim.notify_orig(msg, level, opts)
    end
end

vim.o.updatetime = 250
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
})
