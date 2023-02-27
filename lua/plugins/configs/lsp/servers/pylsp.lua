return {
    lua_ls = function()
        require('lspconfig').lua.setup({
            settings = {
                pylsp = {
                    plugins = {
                        pycodestyle = {
                            ignore = { 'W391' },
                            maxLineLength = 79
                        }
                    }
                }
            }
        })
    end
}
