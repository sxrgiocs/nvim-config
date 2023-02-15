local present, luasnip = pcall(require, "luasnip")

if not present then
    return
end

luasnip.config.set_config {
    history = false,
    --updateevents = "TextChanged,TextChangedI",
    region_check_events = 'CursorHold'
}

-- directory for my custom snippets
--vim.opt.runtimepath = vim.opt.runtimepath .. ''

require("luasnip/loaders/from_vscode").load({paths = '~/.config/nvim/snippets'})
--require("luasnip/loaders/from_vscode").load({paths = '/home/sergio/.local/share/nvim/site/pack/packer/opt/friendly-snippets'})

--require("luasnip/loaders/from_vscode").load()

-- For my future self, you complete the snippet using Tab :D
