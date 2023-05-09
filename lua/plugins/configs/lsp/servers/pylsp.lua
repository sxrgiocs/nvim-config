-- pylsp.lua

-- Define the pylsp function
local function pylsp()
    require('lspconfig').pylsp.setup({
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = {
                        ignore = { 'W391' },
                        maxLineLength = 100
                    }
                }
            }
        }
    })
end

-- Return the pylsp function
return pylsp
