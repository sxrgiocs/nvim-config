-- define the theme to use, which must be selected in the "theme" file
return function()
    local theme_name = require("colors.theme").ui.theme
    local colors = require("colors.themes." .. theme_name .. ".colors")

    local function hi(group, guifg, guibg, gui, guisp)
        local opts = {}

        if guifg then opts.fg = guifg end
        if guibg then opts.bg = guibg end
        if guisp then opts.sp = guisp end

        -- Modern nvim_set_hl expects booleans for gui modifiers (opts.bold = true)
        -- This splits your old strings like "bold,underline" and applies them safely
        if gui then
            for modifier in string.gmatch(gui, "([^,]+)") do
                opts[modifier] = true
            end
        end

        -- The 0 means "apply to global namespace".
        -- This native API creates groups silently if they don't exist yet!
        vim.api.nvim_set_hl(0, group, opts)
    end

    -- Editor colors
    hi("Normal", colors.white, colors.background, nil)
    hi("Bold", nil, nil, "bold")
    hi("Debug", colors.blue, nil, nil)
    hi("Directory", colors.cyan, nil, nil)
    hi("Error", colors.background, colors.red2, nil)
    hi("ErrorMsg", colors.red2, colors.background, "bold")
    hi("Exception", colors.red2, nil, nil)
    hi("FoldColumn", colors.green, nil, nil)
    hi("ModeMsg", colors.black, nil, nil)
    hi("MoreMsg", colors.blue2, nil, nil)
    hi("Search", nil, colors.yellow2, "bold")
    hi("Substitute", nil, colors.blue2, nil)
    hi("Visual", nil, colors.black2, nil)
    hi("VisualNOS", colors.red2, nil, nil)
    hi("Underlined", colors.red2, nil, nil)
    hi("WarninMsg", colors.red2, nil, nil)

    -- Gui colors
    hi("Folded", colors.gray2, colors.black2, "bold")
    hi("MatchParen", colors.green2, colors.black, nil)
    hi("CursorLine", nil, colors.black3, nil)
    hi("CursorLineNr", colors.gray, colors.black3, "bold")
    hi("LineNr", colors.black2, nil, nil)
    hi("NonText", colors.background, nil, nil) -- the ~ characters in the line number column
    hi("statusline", colors.background, colors.background, nil)
    hi("statuslinenc", colors.black2, colors.background, "bold,underline")
    hi("VertSplit", colors.background2, colors.background2, nil)
    hi("SignColumn", nil, colors.background, nil) -- this is the column on the left of the line numbers
    hi("ColorColumn", nil, colors.black3, nil)

    -- Pmenu
    hi("Pmenu", colors.gray2, nil, nil)
    hi("PmenuSel", colors.gray, colors.black2, "bold")

    -- Syntax highlighting
    hi("Boolean", colors.orange, nil, "bold")
    hi("Character", colors.cyan2, nil, nil)
    hi("Comment", colors.black2, nil, "italic")
    hi("String", colors.green2, nil, nil)
    hi("Conditional", colors.blue, nil, nil)
    hi("Constant", colors.green2, nil, nil)
    hi("Define", colors.pink2, nil, nil)
    hi("Delimiter", colors.orange, nil, nil)
    hi("Float", colors.cyan, nil, nil)
    hi("Function", colors.yellow2, nil, nil)
    hi("Identifier", colors.violet, nil, nil)
    hi("Include", colors.orange, nil, nil)
    hi("Keyword", colors.blue, nil, "italic")
    hi("Label", colors.blue2, nil, nil) -- in json, this is basically everything
    hi("Number", colors.orange2, nil, nil)
    hi("Operator", colors.cyan2, nil, nil)
    hi("PreProc", colors.cyan2, nil, nil) -- this is 'equation' 'document' and this sh in latex
    hi("Repeat", colors.blue, nil, nil)
    hi("Special", colors.pink, nil, nil)
    hi("SpecialChar", colors.orange, nil, nil)
    hi("Statement", colors.blue, nil, nil)
    hi("StorageClass", colors.cyan2, nil, nil)
    hi("Structure", colors.pink2, nil, nil)
    hi("Tag", colors.yellow2, nil, nil)
    hi("Todo", colors.yellow2, nil, nil)
    hi("Type", colors.magenta2, nil, nil)
    hi("Typedef", colors.yellow2, nil, nil)

    -- Treesitter mappings
    hi("@keyword.return", colors.cyan, nil, nil)
    hi("@keyword.function", colors.orange, nil, nil)
    hi("@keyword.import", colors.orange2, nil, nil)
    hi("@module", colors.white, nil, nil)
    hi("@function", colors.yellow, nil, nil)
    hi("@function.call", colors.yellow, nil, nil)
    hi("@function.builtin", colors.yellow, nil, nil)
    hi("@variable", colors.white, nil, nil)
    hi("@variable.parameter", colors.purple, nil, nil)
    hi("@type", colors.magenta2, nil, nil)
    hi("@type.builtin", colors.magenta2, nil, nil)
    hi("@number.float", colors.cyan, nil, nil)
    hi("@boolean", colors.orange, nil, "bold")
    hi("@include", colors.orange, nil, nil)

    -- Diff
    hi("DiffAdd", colors.green2, colors.background, nil)
    hi("DiffChange", colors.blue2, colors.background, nil)
    hi("DiffDelete", colors.red2, colors.background, nil)
    hi("DiffText", colors.blue2, colors.background, nil)
    hi("DiffAdded", colors.green2, colors.background, nil)
    hi("DiffFile", colors.red2, colors.background, nil)
    hi("DiffNewFile", colors.green2, colors.background, nil)
    hi("DiffLine", colors.blue2, colors.background, nil)
    hi("DiffRemoved", colors.red2, colors.background, nil)

    -- Git
    hi("gitcommitOverflow", colors.red2, nil, nil)
    hi("gitcommitSummary", colors.green, nil, nil)
    hi("gitcommitComment", colors.black, nil, nil)
    hi("gitcommitUntracked", colors.black, nil, nil)
    hi("gitcommitDiscarded", colors.black, nil, nil)
    hi("gitcommitSelected", colors.black, nil, nil)
    hi("gitcommitHeader", colors.pink2, nil, nil)
    hi("gitcommitSelectedType", colors.blue2, nil, nil)
    hi("gitcommitUnmergedType", colors.blue2, nil, nil)
    hi("gitcommitDiscardedType", colors.blue2, nil, nil)
    hi("gitcommitBranch", colors.orange2, nil, nil)
    hi("gitcommitUntrackedFile", colors.yellow2, nil, nil)
    hi("gitcommitUnmergedFile", colors.red2, nil, nil)
    hi("gitcommitDiscardedFile", colors.magenta2, nil, nil)
    hi("gitcommitSelectedFile", colors.green, nil, nil)

    -- Spell
    hi("SpellBad", colors.background, colors.red2, "bold")
    hi("SpellCap", colors.background, colors.blue2, "bold")
    hi("SpellLocal", colors.background, colors.orange2, "bold")
    hi("SpellRare", colors.background, colors.yellow2, "bold")

    -- Markdown
    hi("markdownCode", colors.green2, nil, nil)
    hi("markdownError", colors.gray2, colors.red2, nil)
    hi("markdownCodeBlock", colors.blue2, colors.background2, nil)
    hi("markdownHeadingDelimiter", colors.orange2, nil, nil)

    -- Python
    hi("pythonOperator", colors.blue2, nil, nil)
    hi("pythonRepeat", colors.blue2, nil, nil)
    hi("pythonInclude", colors.blue2, nil, nil)
    hi("pythonStatement", colors.blue2, nil, nil)

    -- LaTeX
    hi("Conceal", colors.green2, colors.background, nil)

    -- LSP
    hi("DiagnosticsSignError", colors.red, nil, nil)
    hi("DiagnosticError", colors.red, nil, nil)
    hi("DiagnosticUnderlineError", colors.red, colors.black2, nil, colors.red2)
    hi("DiagnosticsSignWarn", colors.orange2, nil, nil)
    hi("DiagnosticWarn", colors.orange2, nil, nil)
    hi("DiagnosticUnderlineWarn", nil, colors.black2, nil, colors.orange2)
    hi("DiagnosticsSignInfo", colors.magenta2, nil, nil)
    hi("DiagnosticInfo", colors.magenta2, nil, nil)
    hi("DiagnosticUnderlineInfo", colors.magenta2, colors.black2, nil, colors.magenta2)
    hi("DiagnosticsSignHint", colors.blue2, nil, nil)
    hi("DiagnosticHint", colors.blue2, nil, nil)
    hi("DiagnosticUnderlineHint", colors.blue2, colors.black2, nil, colors.blue2)
    hi("NormalFloat", nil, colors.background, "bold")

    -- Snacks
    hi("SnacksPickerDirectory", colors.white, nil, nil)
    hi("SnacksPickerDir", colors.white, nil, nil)
    hi("SnacksPickerFile", colors.white, nil, nil)
    hi("SnacksPickerGitStatusModified", colors.yellow, nil, nil)
    hi("SnacksPickerGitStatusAdded", colors.green, nil, nil)
    hi("SnacksPickerGitStatusUntracked", colors.green, nil, nil)
    hi("SnacksPickerGitStatusStaged", colors.green, nil, nil)
    hi("SnacksPickerGitStatusDeleted", colors.red, nil, nil)

    -- NvimTree
    hi("NvimTreeNormal", nil, colors.background2, nil)
    hi("NvimTreeStatuslineNc", colors.background2, colors.background2, nil)
    hi("NvimTreeEmptyFolderName", colors.black, nil, nil)
    hi("NvimTreeFolderIcon", colors.blue2, nil, nil)
    hi("NvimTreeFolderName", colors.blue2, nil, nil)
    hi("NvimTreeOpenedFolderName", colors.blue2, nil, nil)
    hi("NvimTreeRootFolder", colors.yellow2, nil, "bold,underline")
    hi("EndOfBuffer", colors.background2, nil, nil)
    hi("NvimTreeWinSeparator", colors.background, colors.background, nil)

    -- Dashboard
    hi("DashboardHeader", colors.red2, colors.background, nil)
    hi("DashboardCenter", colors.white2, colors.background, nil)
    hi("DashboardShortcut", colors.red2, colors.background, nil)
    hi("DashboardFooter", colors.black, colors.background, nil)

    -- Indent Blankline Plugin
    hi("IndentBlanklineChar", colors.black2, colors.background, nil)

    -- Nvim cmp
    hi("CmpItemAbbr", colors.gray, nil, nil)
    hi("CmpItemAbbrMatch", colors.orange, nil, "bold")
    hi("CmpDoc", colors.yellow, nil, nil)
    hi("CmpItemKind", colors.black2, nil, nil)
    hi("CmpItemMenu", colors.purple, nil, nil)
    hi("CmpNormal", colors.background, nil, nil)

    -- Builtin functions (require, print, type, etc.)
    hi("@function.builtin", colors.red, nil, nil)
end
