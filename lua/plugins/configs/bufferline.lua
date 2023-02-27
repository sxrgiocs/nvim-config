local global_theme = "colors.themes/" .. require("colors.theme").ui.theme
local colors = require(global_theme)

local present, bufferline = pcall(require, "bufferline")
if not present then
    return
end

bufferline.setup {
    options = {
        offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
        buffer_close_icon = "",
        modified_icon = "",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
        show_tab_indicators = true,
        enforce_regular_tabs = false,
        view = "multiwindow",
        show_buffer_close_icons = false,
        separator_style = "thick",
        --mappings = true,
        always_show_bufferline = true,
        numbers = function(opts)
            return string.format('%s', opts.raise(opts.id))
        end,
    },

    highlights = {
        fill = {
            fg = colors.black,
            bg = colors.black -- rest of the bufferline
        },

        background = { -- color of the unselected buffers
            fg = colors.black2,
            bg = colors.black
        },

        -- buffers
        buffer_visible = {
            fg = colors.light_grey,
            bg = colors.background
        },

        buffer_selected = {
            fg = colors.white,
            bg = colors.background,
            bold = true
        },

        -- tabs
        tab = {
            fg = colors.white,
            bg = colors.black
        },

        tab_selected = {
            fg = colors.background,
            bg = colors.background
        },

        tab_close = {
            fg = colors.black,
            bg = colors.black
        },

        indicator_selected = {
            fg = colors.blue,
            bg = colors.background
        },

        -- separators
        separator = {
            fg = colors.black2,
            bg = colors.black
        },

        separator_visible = {
            fg = colors.background,
            bg = colors.background
        },

        separator_selected = {
            fg = colors.background,
            bg = colors.background
        },

        -- modified
        modified = {
            fg = colors.red,
            bg = colors.black
        },

        modified_visible = {
            fg = colors.black2,
            bg = colors.background
        },

        modified_selected = {
            fg = colors.yellow,
            bg = colors.background
        },

        -- close buttons

    }
}
