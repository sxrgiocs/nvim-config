local signs = {
    { name = "DiagnosticSignError", sign = "" },
    { name = "DiagnosticSignWarn", sign = "" },
    { name = "DiagnosticSignInfo", sign = "" },
    { name = "DiagnosticSignHint", sign = "" }
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {texthl = sign.name, text = sign.sign, numhl = ""})
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
   virtual_text = false;
   signs = true,
   underline = true,
   -- set this to true if you want diagnostics to show in insert mode
   update_in_insert = false,
})

-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _opts)
   if msg:match "exit code" then
      return
   end
   if log_level == vim.log.levels.ERROR then
      vim.api.nvim_err_writeln(msg)
   else
      vim.api.nvim_echo({ { msg } }, true, {})
   end
end

-- show diagnostics on hover
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float({focusable=false})]]
