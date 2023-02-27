return {
    lua_ls = function()
        require('lspconfig').lua.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'my_global' } -- Replace with any global variable you want to exclude from diagnostics
                    }
                }
            }
        })
    end
}
