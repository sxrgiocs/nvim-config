-- Define diagnostic signs using vim.diagnostic.config, not vim.fn.sign_define
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

-- Only override vim.notify if not already wrapped
if not vim.notify_orig then
    vim.notify_orig = vim.notify
    vim.notify = function(msg, level, opts)
        if msg:match("exit code") then
            return
        end
        vim.notify_orig(msg, level, opts)
    end
end

-- Automatically show diagnostics in floating window on CursorHold
vim.o.updatetime = 250
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
})
