-- plugins/configs/lsp/lspconfig.lua

require("plugins.configs.lsp.diagnostics")

local lsp = require("lspconfig")
local util = require("lspconfig.util")
local handlers = require("plugins.configs.lsp.servers")

lsp.pylsp.setup({
    cmd = { "pylsp" },
    filetypes = { "python" },
    root_dir = util.root_pattern(
        "pyproject.toml", "setup.py", "setup.cfg",
        "requirements.txt", "Pipfile", ".git"
    ),
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
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
})

lsp.lua_ls.setup({
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_dir = util.root_pattern(
        ".luarc.json", ".luarc.jsonc", ".luacheckrc",
        ".stylua.toml", "stylua.toml", "selene.toml",
        "selene.yml", ".git"
    ),
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
        },
    },
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
})

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "pylsp", "lua_ls" },
    automatic_installation = true,
})
