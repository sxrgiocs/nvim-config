-- lua/config/statusline.lua
local theme_name = require("colors.theme").ui.theme
local colors = require("colors.themes." .. theme_name .. ".colors")

-- Initialize Highlight Groups based on theme colors
vim.api.nvim_set_hl(0, "SlSepLeft", { fg = colors.black3, bg = colors.black })
vim.api.nvim_set_hl(0, "SlLsp", { fg = colors.gray, bg = colors.black3, bold = true })
vim.api.nvim_set_hl(0, "SlSepMidL", { fg = colors.gray2, bg = colors.black3 })
vim.api.nvim_set_hl(0, "SlFile", { fg = colors.background, bg = colors.gray2, bold = true })
vim.api.nvim_set_hl(0, "SlSepMidR", { fg = colors.gray2, bg = colors.black2 })
vim.api.nvim_set_hl(0, "SlDiagErr", { fg = colors.red, bg = colors.black2 })
vim.api.nvim_set_hl(0, "SlDiagWarn", { fg = colors.yellow, bg = colors.black2 })
vim.api.nvim_set_hl(0, "SlDiagInfo", { fg = colors.cyan, bg = colors.black2 })
vim.api.nvim_set_hl(0, "SlDiagHint", { fg = colors.blue, bg = colors.black2 })
vim.api.nvim_set_hl(0, "SlDiagOk", { fg = colors.green, bg = colors.black2 })
vim.api.nvim_set_hl(0, "SlSepRight", { fg = colors.black2, bg = colors.black })
vim.api.nvim_set_hl(0, "SlNormal", { fg = colors.gray, bg = colors.black })
vim.api.nvim_set_hl(0, "SlLoc", { fg = colors.orange2, bg = colors.black, bold = true }) -- line and column
vim.api.nvim_set_hl(0, "SlGitBranchSepL", { fg = colors.black3, bg = colors.black })
vim.api.nvim_set_hl(0, "SlGitBranch", { fg = colors.green2, bg = colors.black3, bold = true })
vim.api.nvim_set_hl(0, "SlGitBranchSepR", { fg = colors.black3, bg = colors.black2 })

vim.api.nvim_set_hl(0, "", { fg = colors.black2, bg = colors.black2 })
vim.api.nvim_set_hl(0, "SlGitChangesSepR", { fg = colors.black2, bg = colors.black })

vim.api.nvim_set_hl(0, "SlGitAddSquare", { fg = colors.green, bg = colors.black2 })
vim.api.nvim_set_hl(0, "SlGitModSquare", { fg = colors.blue, bg = colors.black2 })
vim.api.nvim_set_hl(0, "SlGitRemSquare", { fg = colors.red, bg = colors.black2 })
vim.api.nvim_set_hl(0, "SlGitDimSquare", { fg = colors.black, bg = colors.black2 })
vim.api.nvim_set_hl(0, "SlGitText", { fg = colors.gray, bg = colors.black2 })
vim.api.nvim_set_hl(0, "SlOpt", { fg = colors.black2, bg = colors.black, bold = true })

-- Dynamic Mode Colors
local mode_colors = {
    -- Normal & Operators
    n       = colors.gray2,
    no      = colors.red,   -- Operator-pending (waiting for motion after d, y, c)
    ['niI'] = colors.gray2, -- Normal mode via <C-O> from Insert
    ['nt']  = colors.gray2, -- Normal mode inside a terminal buffer
    -- Insert
    i       = colors.green,
    -- Visual
    v       = colors.pink, -- Characterwise Visual
    V       = colors.pink, -- Linewise Visual
    ['\22'] = colors.pink, -- Blockwise Visual (<C-V>)
    -- Select (used by snippet engines like LuaSnip)
    s       = colors.blue, -- Characterwise Select
    S       = colors.blue, -- Linewise Select
    ['\19'] = colors.blue, -- Blockwise Select (<C-S>)
    -- Replace
    R       = colors.red,
    -- Command-line
    c       = colors.yellow,
    -- Terminal
    t       = colors.cyan,
}

local function get_mode_hl()
    local mode = vim.fn.mode()
    local mode_color = mode_colors[mode] or colors.red
    -- Dynamically update the SlMode highlight group
    vim.api.nvim_set_hl(0, "SlMode", { fg = mode_color, bg = colors.black })
    return "%#SlMode#"
end

local function get_lsp()
    local msg = ' No Active Lsp '
    local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if next(clients) == nil then
        return msg
    end

    local names = {}
    for _, client in ipairs(clients) do
        if client.name ~= "copilot" then
            table.insert(names, client.name)
        end
    end

    if #names == 0 then
        table.insert(names, clients[1].name)
    end

    local icons = {
        lua = '',
        python = '',
        rust = '',
        javascript = '',
        typescript = '',
        go = '',
        html = '',
        css = '',
        json = '',
        yaml = '',
        markdown = '',
    }
    local icon = icons[buf_ft] or ''
    return ' ' .. icon .. ' ' .. table.concat(names, ", ") .. ' '
end

local function get_diagnostics()
    local counts = { 0, 0, 0, 0 } -- E, W, I, H
    local diagnostics = vim.diagnostic.get(0)
    for _, d in ipairs(diagnostics) do
        if d.severity >= 1 and d.severity <= 4 then
            counts[d.severity] = counts[d.severity] + 1
        end
    end
    local res = ""
    if counts[1] > 0 then res = res .. "%#SlDiagErr# " .. counts[1] .. " " end
    if counts[2] > 0 then res = res .. "%#SlDiagWarn# " .. counts[2] .. " " end
    if counts[3] > 0 then res = res .. "%#SlDiagInfo# " .. counts[3] .. " " end
    if counts[4] > 0 then res = res .. "%#SlDiagHint#󰌶 " .. counts[4] .. " " end

    if res == "" then
        return "%#SlDiagOk# "
    end
    return res
end

local function get_git()
    local dict = vim.b.gitsigns_status_dict
    if not dict or not dict.head then return "" end

    -- 1. Branch Bubble (on light black3, same as LSP)
    local branch_str = "%#SlGitBranchSepL#%#SlGitBranch# " .. dict.head .. " %#SlGitBranchSepR#"

    -- 2. Changes Bubble (on darker black2, same as diagnostics)
    local added = dict.added or 0
    local changed = dict.changed or 0
    local removed = dict.removed or 0

    local changes_str = ""

    -- Added Square
    if added > 0 then
        changes_str = changes_str .. "%#SlGitAddSquare#●%#SlGitText# " .. added .. " "
    else
        changes_str = changes_str .. "%#SlGitDimSquare#● "
    end

    -- Modified Square
    if changed > 0 then
        changes_str = changes_str .. "%#SlGitModSquare#●%#SlGitText# " .. changed .. " "
    else
        changes_str = changes_str .. "%#SlGitDimSquare#● "
    end

    -- Removed Square
    if removed > 0 then
        changes_str = changes_str .. "%#SlGitRemSquare#●%#SlGitText# " .. removed
    else
        changes_str = changes_str .. "%#SlGitDimSquare#●"
    end

    changes_str = changes_str .. "%#SlGitChangesSepR#"

    return branch_str .. " " .. changes_str .. " "
end

local function get_filesize()
    local file = vim.fn.expand('%:p')
    if string.len(file) == 0 then return '' end
    local size = vim.fn.getfsize(file)
    if size <= 0 then return '' end
    local sufixes = { 'b', 'k', 'm', 'g' }
    local i = 1
    while size > 1024 do
        size = size / 1024
        i = i + 1
    end
    return string.format('%.1f%s', size, sufixes[i])
end

_G.NativeStatusLine = function()
    -- Ensure window is wide enough for some components
    local width = vim.fn.winwidth(0)
    local hide_in_width = width > 80

    local st = ""

    -- Left block
    -- Home
    st = st .. get_mode_hl() .. "▊  "
    -- LSP server
    st = st .. "%#SlSepLeft#"
    st = st .. "%#SlLsp#" .. get_lsp()
    -- Filename with parent folder
    local filename = vim.fn.expand('%:t')
    if filename == "" then
        filename = "[No Name]"
    else
        local parent = vim.fn.expand('%:p:h:t')
        if parent ~= "" and parent ~= "." then
            filename = " " .. parent .. "/" .. filename .. " "
        else
            filename = " " .. filename .. " "
        end
    end
    st = st .. "%#SlSepMidL#"
    st = st .. "%#SlFile#" .. filename
    st = st .. "%#SlSepMidR# "
    -- LSP diagnostic
    local diag = get_diagnostics()
    if diag ~= "" then
        st = st .. diag
    end
    st = st .. "%#SlSepRight# "
    -- Line and column
    st = st .. "%#SlLoc#%l:%c "
    -- File percentage
    st = st .. " %#SlNormal#%p%%  "

    -- Middle separator (aligns everything after to the right)
    st = st .. "%="

    -- Right block
    -- File encoding
    if hide_in_width then
        st = st .. get_git()
        st = st .. "%#SlOpt#" .. string.upper(vim.bo.fileencoding or "") .. "  "
    end
    -- File format
    st = st .. "%#SlOpt#" .. string.upper(vim.bo.fileformat or "") .. "  "
    -- File size
    local fsize = get_filesize()
    if fsize ~= "" then
        st = st .. "%#SlNormal#" .. fsize .. " "
    end
    -- Ending tail
    st = st .. "%#SlOpt#▊"

    return st
end

-- Use global statusline and set the string to evaluate our function
vim.o.laststatus = 3
vim.o.statusline = "%!v:lua.NativeStatusLine()"
