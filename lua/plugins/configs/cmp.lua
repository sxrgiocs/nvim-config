local present, cmp = pcall(require, "cmp")

if not present then
    return
end

vim.opt.completeopt = "menuone,noselect"

-- nvim-cmp setup
cmp.setup {
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },

    enabled = function()
        local in_prompt = vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt'
        if in_prompt then -- this will disable cmp in the Telescope window (taken from the default config)
            return false
        end
        local context = require("cmp.config.context")
        return not (context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment"))
    end,

    formatting = {
        format = function(entry, vim_item)
            -- load lspkind icons
            vim_item.kind = string.format(
                "%s %s",
                require("plugins.configs.lsp.lspkind").icons[vim_item.kind],
                vim_item.kind
            )

            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                buffer = "[BUF]",
            })[entry.source.name]

            return vim_item
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-c>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },

        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
                fallback()
            end
        end,

        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
                fallback()
            end
        end,
    },
    sources = {

        { name = "copilot", group_index = 2 },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
    },
}
