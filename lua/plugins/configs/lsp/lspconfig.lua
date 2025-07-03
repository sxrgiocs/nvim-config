-- lspconfig.lua

local nvim_lsp = require('lspconfig')
local lsp_util = require('lspconfig.util')

-- On_attach function to set keymaps and format on save
local on_attach = function(client, bufnr)
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

  -- Format on save
  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = bufnr,
    callback = function() vim.lsp.buf.format() end,
  })
end

-- Optional: Define capabilities if you want to enhance completion, etc.
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- e.g., enhance with cmp_nvim_lsp if you use nvim-cmp (uncomment below)
-- local cmp_nvim_lsp = require('cmp_nvim_lsp')
-- capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Register pylsp config using the new vim.lsp.config interface
vim.lsp.config.pylsp = {
  cmd = { "pylsp" },
  filetypes = { "python" },
  root_dir = lsp_util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git"),
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          enabled = true,
          ignore = { "W391", "E501" },
          maxLineLength = 200,
        },
        -- you can enable or disable other pylsp plugins here
      },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Set up other language servers similarly if you want
vim.lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_dir = lsp_util.root_pattern(".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git"),
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Now, use lspconfig to setup the servers explicitly
nvim_lsp.pylsp.setup(vim.lsp.config.pylsp)
nvim_lsp.lua_ls.setup(vim.lsp.config.lua_ls)

-- Mason setup to ensure servers are installed
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { "pylsp", "lua_ls" }
})

-- No longer need handlers in mason-lspconfig; just rely on lspconfig setup above
