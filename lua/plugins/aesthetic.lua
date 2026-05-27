return {
    -- to show colors when they are RGB or HEX inside the file in the editor
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require 'plugins.configs.colorizer'
        end,
    }
}
