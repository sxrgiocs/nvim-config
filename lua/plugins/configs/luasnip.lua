local present, luasnip = pcall(require, "luasnip")

if not present then
    return
end

luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    region_check_events = 'CursorHold'
}

-- logging
-- luasnip.log.set_loglevel("info")
-- luasnip.log.open()

-- snipmate (.snippets snipets)
-- require('luasnip.loaders.from_snipmate').lazy_load({ paths = '~/.config/nvim/snippets', })

-- vscode format (.json snippets)
require('luasnip.loaders.from_vscode').lazy_load({ paths = '~/.config/nvim/snippets', })

-- For my future self, you complete the snippet using Tab :D
