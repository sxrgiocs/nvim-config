-- lua/plugins/configs/snacks.lua

local theme_name = require("colors.theme").ui.theme
local colors = require("colors.themes." .. theme_name .. ".colors")

-- Define base colors for Snacks Explorer and Picker
local bg = colors.background2
local border = colors.gray2
local fg = colors.white

-- Set up the actual highlight groups used by snacks.nvim
local hl_groups = {
    SnacksPicker = { fg = fg, bg = bg },
    SnacksPickerList = { fg = fg, bg = bg },
    SnacksPickerInput = { fg = fg, bg = bg },
    SnacksPickerPreview = { fg = fg, bg = bg },
    SnacksPickerBorder = { fg = border, bg = bg },
    SnacksPickerListBorder = { fg = border, bg = bg },
    SnacksPickerInputBorder = { fg = border, bg = bg },
    SnacksPickerPreviewBorder = { fg = border, bg = bg },
    SnacksPickerTitle = { fg = fg, bg = bg },
    SnacksPickerListTitle = { fg = fg, bg = bg },
    SnacksPickerInputTitle = { fg = fg, bg = bg },
    SnacksPickerPreviewTitle = { fg = fg, bg = bg },
    SnacksPickerBox = { fg = fg, bg = bg },
    SnacksPickerBoxBorder = { fg = border, bg = bg },
    SnacksPickerBoxTitle = { fg = fg, bg = bg },
    SnacksNormal = { fg = fg, bg = bg },
    SnacksNormalNC = { fg = fg, bg = bg },
    SnacksWinBar = { fg = fg, bg = bg },
    SnacksWinBarNC = { fg = fg, bg = bg },
    SnacksTitle = { fg = fg, bg = bg },
    SnacksWinSeparator = { fg = bg, bg = bg },
    WinSeparator = { fg = bg, bg = bg },

    -- Git Status highlights inside Snacks Picker/Explorer
    -- SnacksPickerGitStatusAdded = { fg = colors.green, bg = bg },
    SnacksPickerGitStatusModified = { fg = colors.orange2, bg = bg },
    SnacksPickerGitStatusDeleted = { fg = colors.red, bg = bg },
    SnacksPickerGitStatusRenamed = { fg = colors.purple, bg = bg },
    SnacksPickerGitStatusCopied = { fg = colors.purple, bg = bg },
    SnacksPickerGitStatusUntracked = { fg = colors.green, bg = bg },
    SnacksPickerGitStatusIgnored = { fg = colors.black2, bg = bg },
    SnacksPickerGitStatusUnmerged = { fg = colors.red, bg = bg },
    SnacksPickerGitStatusStaged = { fg = colors.green2, bg = bg },
}

for hl_name, hl_def in pairs(hl_groups) do
    vim.api.nvim_set_hl(0, hl_name, hl_def)
end

require("snacks").setup({
    picker = {
        enabled = true,
        icons = {
            git = {
                enabled   = true,
                commit    = "󰜘 ",
                staged    = "●",
                added     = "",
                deleted   = "",
                ignored   = " ",
                modified  = "○",
                renamed   = "",
                unmerged  = " ",
                untracked = "●",
            },
        },
    },
})
