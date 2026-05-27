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
    hi("Normal", colors.gray, colors.background, nil)
    hi("Bold", nil, nil, "bold")
    hi("Debug", colors.blue2, nil, nil)
    hi("Directory", colors.blue, nil, nil)
    hi("Error", colors.background, colors.red, nil)
    hi("ErrorMsg", colors.red, colors.background, "bold")
    hi("Exception", colors.red, nil, nil)
    hi("FoldColumn", colors.green2, nil, nil)
    hi("ModeMsg", colors.black2, nil, nil)
    hi("MoreMsg", colors.blue, nil, nil)
    hi("Search", nil, colors.yellow, "bold")
    hi("Substitute", nil, colors.blue, nil)
    hi("Visual", nil, colors.black, nil)
    hi("VisualNOS", colors.red, nil, nil)
    hi("Underlined", colors.red, nil, nil)
    hi("WarninMsg", colors.red, nil, nil)

    -- Gui colors
    hi("Folded", colors.gray, colors.black, "bold")
    hi("MatchParen", colors.green, colors.black2, nil)
    hi("CursorLine", nil, colors.black3, nil)
    hi("CursorLineNr", colors.orange, colors.black3, "bold")
    hi("LineNr", colors.black, nil, nil)
    hi("NonText", colors.background, nil, nil) -- the ~ characters in the line number column
    hi("statusline", colors.background, colors.background, nil)
    hi("statuslinenc", colors.black, colors.background, "bold,underline")
    hi("VertSplit", colors.background2, colors.background2, nil)
    hi("SignColumn", nil, colors.background, nil) -- this is the column on the left of the line numbers
    hi("ColorColumn", nil, colors.black3, nil)

    -- Pmenu
    hi("Pmenu", colors.gray, colors.background, nil)
    hi("PmenuSel", colors.blue2, colors.black, "bold")

    -- Syntax highlighting
    hi("Boolean", colors.orange, nil, "bold")
    hi("Character", colors.cyan, nil, nil)
    hi("Comment", colors.black2, nil, "italic")
    hi("String", colors.green, nil, nil)
    hi("Conditional", colors.pink, nil, nil)
    hi("Constant", colors.green, nil, nil)
    hi("Define", colors.pink, nil, nil)
    hi("Delimiter", colors.orange2, nil, nil)
    hi("Float", colors.orange, nil, nil)
    hi("Function", colors.blue, nil, nil)
    hi("Identifier", colors.gray2, nil, nil)
    hi("Include", colors.green, nil, nil)
    hi("Keyword", colors.purple, nil, "italic")
    hi("Label", colors.blue, nil, nil) -- in json, this is basically everything
    hi("Number", colors.orange, nil, nil)
    hi("Operator", colors.cyan, nil, nil)
    hi("PreProc", colors.cyan, nil, nil) -- this is 'equation' 'document' and this sh in latex
    hi("Repeat", colors.yellow, nil, nil)
    hi("Special", colors.pink, nil, nil)
    hi("SpecialChar", colors.orange2, nil, nil)
    hi("Statement", colors.blue, nil, nil)
    hi("StorageClass", colors.cyan, nil, nil)
    hi("Structure", colors.pink, nil, nil)
    hi("Tag", colors.yellow, nil, nil)
    hi("Todo", colors.yellow, nil, nil)
    hi("Type", colors.cyan, nil, nil)
    hi("Typedef", colors.yellow, nil, nil)

    -- Diff
    hi("DiffAdd", colors.green, colors.background, nil)
    hi("DiffChange", colors.blue, colors.background, nil)
    hi("DiffDelete", colors.red, colors.background, nil)
    hi("DiffText", colors.blue, colors.background, nil)
    hi("DiffAdded", colors.green, colors.background, nil)
    hi("DiffFile", colors.red, colors.background, nil)
    hi("DiffNewFile", colors.green, colors.background, nil)
    hi("DiffLine", colors.blue, colors.background, nil)
    hi("DiffRemoved", colors.red, colors.background, nil)

    -- Git
    hi("gitcommitOverflow", colors.red, nil, nil)
    hi("gitcommitSummary", colors.green2, nil, nil)
    hi("gitcommitComment", colors.black2, nil, nil)
    hi("gitcommitUntracked", colors.black2, nil, nil)
    hi("gitcommitDiscarded", colors.black2, nil, nil)
    hi("gitcommitSelected", colors.black2, nil, nil)
    hi("gitcommitHeader", colors.pink, nil, nil)
    hi("gitcommitSelectedType", colors.blue, nil, nil)
    hi("gitcommitUnmergedType", colors.blue, nil, nil)
    hi("gitcommitDiscardedType", colors.blue, nil, nil)
    hi("gitcommitBranch", colors.orange, nil, nil)
    hi("gitcommitUntrackedFile", colors.yellow, nil, nil)
    hi("gitcommitUnmergedFile", colors.red, nil, nil)
    hi("gitcommitDiscardedFile", colors.purple, nil, nil)
    hi("gitcommitSelectedFile", colors.green2, nil, nil)

    -- Spell
    hi("SpellBad", colors.background, colors.red, "bold")
    hi("SpellCap", colors.background, colors.blue, "bold")
    hi("SpellLocal", colors.background, colors.orange, "bold")
    hi("SpellRare", colors.background, colors.yellow, "bold")

    -- Markdown
    hi("markdownCode", colors.green, nil, nil)
    hi("markdownError", colors.gray, colors.red, nil)
    hi("markdownCodeBlock", colors.blue, colors.background2, nil)
    hi("markdownHeadingDelimiter", colors.orange, nil, nil)

    -- Python
    hi("pythonOperator", colors.blue, nil, nil)
    hi("pythonRepeat", colors.blue, nil, nil)
    hi("pythonInclude", colors.blue, nil, nil)
    hi("pythonStatement", colors.blue, nil, nil)

    -- LaTeX
    hi("Conceal", colors.green, colors.background, nil)

    -- LSP
    hi("DiagnosticsSignError", colors.red2, nil, nil)
    hi("DiagnosticError", colors.red2, nil, nil)
    hi("DiagnosticUnderlineError", colors.red2, colors.black, nil, colors.red)
    hi("DiagnosticsSignWarn", colors.orange, nil, nil)
    hi("DiagnosticWarn", colors.orange, nil, nil)
    hi("DiagnosticUnderlineWarn", nil, colors.black, nil, colors.orange)
    hi("DiagnosticsSignInfo", colors.purple, nil, nil)
    hi("DiagnosticInfo", colors.purple, nil, nil)
    hi("DiagnosticUnderlineInfo", colors.purple, colors.black, nil, colors.purple)
    hi("DiagnosticsSignHint", colors.blue, nil, nil)
    hi("DiagnosticHint", colors.blue, nil, nil)
    hi("DiagnosticUnderlineHint", colors.blue, colors.black, nil, colors.blue)
    hi("NormalFloat", nil, colors.background, "bold")

    -- Diagnostics

    -- NvimTree
    hi("NvimTreeNormal", nil, colors.background2, nil)
    hi("NvimTreeStatuslineNc", colors.background2, colors.background2, nil)
    hi("NvimTreeEmptyFolderName", colors.black2, nil, nil)
    hi("NvimTreeFolderIcon", colors.blue, nil, nil)
    hi("NvimTreeFolderName", colors.blue, nil, nil)
    hi("NvimTreeOpenedFolderName", colors.blue, nil, nil)
    hi("NvimTreeRootFolder", colors.yellow, nil, "bold,underline")
    hi("EndOfBuffer", colors.background2, nil, nil)
    hi("NvimTreeWinSeparator", colors.background, colors.background, nil)

    -- Dashboard
    hi("DashboardHeader", colors.red, colors.background, nil)
    hi("DashboardCenter", colors.white, colors.background, nil)
    hi("DashboardShortcut", colors.red, colors.background, nil)
    hi("DashboardFooter", colors.black2, colors.background, nil)

    -- Indent Blankline Plugin
    hi("IndentBlanklineChar", colors.black, colors.background, nil)

    -- Nvim cmp
    hi("CmpItemAbbr", colors.gray2, nil, nil)
    hi("CmpItemAbbrMatch", colors.blue, nil, "bold")
    hi("CmpDoc", colors.blue, nil, nil)
    hi("CmpItemKind", colors.cyan, nil, nil)
    hi("CmpItemMenu", colors.blue, nil, nil)
    hi("CmpNormal", colors.background, nil, nil)
end
