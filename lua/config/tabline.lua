-- lua/config/tabline.lua

local theme_name = require("colors.theme").ui.theme
local colors = require("colors.themes." .. theme_name .. ".colors")

-- Initialize Highlight Groups
vim.api.nvim_set_hl(0, "TabLine", { underline = false })
vim.api.nvim_set_hl(0, "TabLineSel", { underline = false })
vim.api.nvim_set_hl(0, "TabLineFill", { underline = false })

vim.api.nvim_set_hl(0, "TlFill", { fg = colors.black2, bg = colors.black3, underline = false })
vim.api.nvim_set_hl(0, "TlExplorerSpacer", { bg = colors.background2, underline = false })
vim.api.nvim_set_hl(0, "TlActive", { fg = colors.gray, bg = colors.background, bold = true, underline = false })
vim.api.nvim_set_hl(0, "TlActiveIcon", { fg = colors.blue, bg = colors.background, underline = false })
vim.api.nvim_set_hl(0, "TlActiveNum", { fg = colors.gray, bg = colors.background, bold = true, underline = false })
vim.api.nvim_set_hl(0, "TlInactive", { fg = colors.black2, bg = colors.black3, underline = false })
vim.api.nvim_set_hl(0, "TlInactiveIcon", { fg = colors.black2, bg = colors.black3, underline = false })
vim.api.nvim_set_hl(0, "TlInactiveNum", { fg = colors.black2, bg = colors.black3, bold = true, underline = false })
vim.api.nvim_set_hl(0, "TlSep", { fg = colors.visual_bg, bg = colors.visual_fg, underline = false })

-- Native click handler for buffers
_G.TablineClick = function(minwid, clicks, button, modifiers)
    if button == "l" then
        vim.cmd("buffer " .. minwid)
    elseif button == "m" then
        vim.cmd("bdelete " .. minwid)
    end
end

_G.NativeTabLine = function()
    local s = ""

    -- Dynamic offset if Snacks Explorer is open on the left
    local explorer_width = 0
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })
        if ft == "snacks_layout_box" then
            local col = vim.api.nvim_win_get_position(win)[2]
            if col == 0 then
                explorer_width = vim.api.nvim_win_get_width(win) + 1
                break
            end
        end
    end
    if explorer_width > 0 then
        s = s .. "%#TlExplorerSpacer#" .. string.rep(" ", explorer_width)
    end

    local bufs = vim.api.nvim_list_bufs()
    local listed_bufs = {}
    for _, b in ipairs(bufs) do
        if vim.api.nvim_get_option_value('buflisted', { buf = b }) then
            table.insert(listed_bufs, b)
        end
    end

    local current_buf = vim.api.nvim_get_current_buf()

    for index, b in ipairs(listed_bufs) do
        local is_active = (b == current_buf)
        local name = vim.fn.bufname(b)
        if name == "" then
            name = "[No Name]"
        else
            name = vim.fn.fnamemodify(name, ":t")
        end

        local ext = vim.fn.fnamemodify(name, ":e")
        local icon = ""
        local ok, devicons = pcall(require, "nvim-web-devicons")
        if ok then
            icon = devicons.get_icon(name, ext, { default = true }) or ""
        end

        local hl_num = is_active and "%#TlActiveNum#" or "%#TlInactiveNum#"
        local hl_icon = is_active and "%#TlActiveIcon#" or "%#TlInactiveIcon#"
        local hl_text = is_active and "%#TlActive#" or "%#TlInactive#"

        -- Add separator if not first
        if index > 1 then
            s = s .. "%#TlSep#▏"
        end

        -- Click handler macro (switch buffer with left click, close with middle click)
        s = s .. "%" .. b .. "@v:lua.TablineClick@"

        s = s .. hl_num .. " " .. index .. " "
        if icon ~= "" then
            s = s .. hl_icon .. icon .. " "
        end
        s = s .. hl_text .. name .. " "

        -- End click handler macro
        s = s .. "%X"
    end

    -- Fill the rest of the tabline with the fill color
    s = s .. "%#TlFill#"
    return s
end

-- Always show the tabline
vim.o.showtabline = 2
-- Set the tabline evaluator
vim.o.tabline = "%!v:lua.NativeTabLine()"
