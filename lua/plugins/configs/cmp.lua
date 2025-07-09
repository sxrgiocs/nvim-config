local present, cmp = pcall(require, "cmp")
if not present then return end

vim.opt.completeopt = { "menuone", "noselect" }

cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },


    window = {
        completion = cmp.config.window.bordered({
            border = 'single',
            winhighlight = 'Normal:Pmenu,Floatborder:Pmenu,CursorLine:PmenuSel,Search:none'
        }),
    },

    enabled = function()
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })
        if buftype == "prompt" then
            return false
        end
        local context = require("cmp.config.context")
        return not (context.in_treesitter_capture("comment") or context.in_syntax_group("Comment"))
    end,

    formatting = {
        format = function(entry, vim_item)
            local kind_icons = require("plugins.configs.lsp.lspkind").icons or {}
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or "", vim_item.kind)

            vim_item.menu = ({
                nvim_lsp = " lsp",
                nvim_lua = " lua",
                buffer = "󰈙 buf",
                luasnip = " snip",
                copilot = " copilot", -- optional, if you want to visually distinguish
            })[entry.source.name] or ""

            return vim_item
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-c>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        ["<Tab>"] = function(fallback)
            local luasnip = require("luasnip")
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,

        ["<S-Tab>"] = function(fallback)
            local luasnip = require("luasnip")
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    }),

    sources = cmp.config.sources({
        { name = "copilot", group_index = 2 },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
    }),
})
