local is_picking_focus = require('cokeline.mappings').is_picking_focus
local is_picking_close = require('cokeline.mappings').is_picking_close
local get_hex = require('cokeline.hlgroups').get_hl_attr

local theme_name = require("colors.theme").ui.theme
local colors = require("colors.themes." .. theme_name .. ".colors")

-- Diagnostic icons and colors
local diagnostic_icons = {
    [vim.diagnostic.severity.ERROR] = { icon = '', color = colors.red },
    [vim.diagnostic.severity.WARN]  = { icon = '', color = colors.yellow },
    [vim.diagnostic.severity.INFO]  = { icon = '', color = colors.blue },
    [vim.diagnostic.severity.HINT]  = { icon = '', color = colors.comment },
}

-- Returns diagnostics summary (icon+count) and its highlight color
local function get_diagnostic_summary(buffer)
    local diagnostics = vim.diagnostic.get(buffer.bufnr)
    if not diagnostics or vim.tbl_isempty(diagnostics) then
        return '', nil
    end

    local counts = {
        [vim.diagnostic.severity.ERROR] = 0,
        [vim.diagnostic.severity.WARN]  = 0,
        [vim.diagnostic.severity.INFO]  = 0,
        [vim.diagnostic.severity.HINT]  = 0,
    }

    for _, d in ipairs(diagnostics) do
        counts[d.severity] = counts[d.severity] + 1
    end

    for severity = vim.diagnostic.severity.ERROR, vim.diagnostic.severity.HINT do
        if counts[severity] > 0 then
            local entry = diagnostic_icons[severity]
            return string.format('%s %d ', entry.icon, counts[severity]), entry.color
        end
    end

    return '', nil
end

require('cokeline').setup({
    default_hl = {
        fg = function(buffer)
            return buffer.is_focused and colors.black or colors.black3
        end,
        bg = function(buffer)
            return colors.background
        end,
    },

    -- Set the fill highlight (rest of the line)
    vim.api.nvim_set_hl(0, 'TabLineFill', {
        bg = colors.black3,
        fg = colors.black2,
    }),

    components = {
        -- Vertical separator
        {
            text = function(buffer)
                return (buffer.index ~= 1) and '▏' or ''
            end,
            fg = function() return colors.visual_bg end,
            bg = function() return colors.visual_fg end,
        },

        -- Buffer number
        {
            text = function(buffer)
                return ' ' .. buffer.index .. ' '
            end,
            fg = function(buffer)
                return buffer.is_focused and colors.gray or colors.black2
            end,
            bg = function(buffer)
                return buffer.is_focused and colors.black or colors.black3
            end,
            bold = true,
        },

        -- Filetype icon
        {
            text = function(buffer)
                local icon = buffer.devicon.icon or ''
                return icon .. ' '
            end,
            fg = function(buffer)
                return buffer.is_focused and colors.blue or colors.black2
            end,
            bg = function(buffer)
                return buffer.is_focused and colors.black or colors.black3
            end,
        },

        -- Filename
        {
            text = function(buffer) return buffer.filename .. ' ' end,
            bold = function(buffer) return buffer.is_focused end,
            fg = function(buffer) return buffer.is_focused and colors.gray or colors.black2 end,
            bg = function(buffer) return buffer.is_focused and colors.black or colors.black3 end,
        },

        -- LSP diagnostics summary
        -- {
        --     text = function(buffer)
        --         local summary, _ = get_diagnostic_summary(buffer)
        --         return summary
        --     end,
        --     fg = function(buffer)
        --         local _, color = get_diagnostic_summary(buffer)
        --         return color or colors.comment
        --     end,
        --     bg = function(buffer)
        --         return buffer.is_focused and colors.background or colors.background2
        --     end,
        -- },

        -- Close icon
        {
            text = ' ',
            fg = function(buffer) return buffer.is_focused and colors.red or colors.black2 end,
            bg = function(buffer) return buffer.is_focused and colors.black or colors.black3 end,
            on_click = function(_, _, _, _, buffer)
                buffer:delete()
            end,
            bold = true,
        },
    }
})
