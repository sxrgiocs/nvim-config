
local status, mason = pcall(require, "mason")
    if (not status) then return end

local status2, lspconfig = pcall(require, "mason-lspconfig")
    if (not status2) then return end

mason.setup({

})

lspconfig.setup {
  ensure_installed = { "lua_ls" },
}  

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = {spacing = 5, severity_limit = 'Warning'},
  update_in_insert = true
})

