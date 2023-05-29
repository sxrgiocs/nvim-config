local present1, gl = pcall(require, "galaxyline")

local present2, condition = pcall(require, "galaxyline.condition")
if not (present1 or present2) then
    return
end

local gls = gl.section

local lspclient = require("galaxyline.providers.lsp")

gl.short_line_list = { " " }

local global_theme = "colors.themes/" .. require("colors.theme").ui.theme
local colors = require(global_theme)

gls.left[1] = {
    ViMode = {
        provider = function()
            local alias = {
                n = "NORMAL",
                no = "N-OPERATOR",
                v = "VISUAL",
                V = "V-LINE",
                [""] = "V-BLOCK",
                s = "SELECT",
                S = "S-LINE",
                [""] = "S-BLOCK",
                i = "INSERT",
                ic = "I-COMPLETION",
                ix = "I-X-COMP",
                R = "REPLACE",
                Rc = "R-COMPLETION",
                Rv = "R-VIRTUAL",
                Rx = "R-X-COMP",
                c = "COMMAND",
                cv = "EX",
                r = "PROMPT",
                rm = "MORE",
                ["r?"] = "CONFIRM",
                ["!"] = "EXT COMMAND",
                t = "TERMINAL",
            }
            local mode_color = {
                n = colors.blue,
                i = colors.green,
                v = colors.pink,
                [''] = colors.pink,
                V = colors.pink,
                c = colors.black2,
                no = colors.blue,
                s = colors.orange,
                S = colors.orange,
                [''] = colors.orange,
                ic = colors.yellow,
                R = colors.red,
                Rv = colors.red,
                cv = colors.red,
                ce = colors.red,
                r = colors.cyan,
                rm = colors.cyan,
                ['r?'] = colors.cyan,
                ['!'] = colors.red,
                t = colors.black3
            }

            vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim.fn.mode()])
            --return '   ' .. alias[vim.fn.mode()] .. ' '
            return '  ' .. alias[vim.fn.mode()] .. ' '
        end,

        highlight = { colors.black, colors.black, 'bold' },
    },
}

gls.left[2] = {
    RoundLeftElement1 = {
        provider = function()
            return ""
        end,
        highlight = { colors.gray2, colors.black }
    }
}



gls.left[3] = {
    FileIcon = {
        provider = require("galaxyline.providers.fileinfo").get_file_icon,
        highlight = { colors.black, colors.gray2 },
    },
}


gls.left[4] = {
    LspServer = {
        provider = function()
            local curr_client = lspclient.get_lsp_client()
            if curr_client ~= "No Active Lsp" then
                return ' ' .. curr_client .. ''
            end
        end,
        highlight = { colors.black, colors.gray2, 'bold' },
    },
}

gls.left[5] = {
    RoundRightElement1 = {
        provider = function()
            return " "
        end,
        highlight = { colors.gray2, colors.black2 }
    }
}

gls.left[6] = {
    current_dir = {
        provider = function()
            local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            return "  " .. dir_name .. "/"
        end,
        highlight = { colors.white, colors.black2 },
    }
}

gls.left[7] = {
    filename = {
        provider = function()
            local file_name = vim.fn.expand("%:t")
            return file_name
        end,
        highlight = { colors.white, colors.black2 }
    }
}


local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 30 then
        return true
    end
    return false
end

gls.left[8] = {
    -- modified/special icons
    Modified = {
        provider = function()
            if vim.bo.readonly then
                return '   '
            end
            if not vim.bo.modifiable then
                return '   '
            end
        end,
        highlight = { colors.gray, colors.black2 },
    }
}


gls.left[9] = {
    RoundRightElement2 = {
        provider = function()
            return " "
        end,
        highlight = { colors.black2, colors.black }
    }
}

gls.left[10] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = { colors.orange, colors.black }
    }
}

gls.left[11] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = { colors.red, colors.black }
    }
}

gls.right[1] = {
    GitIcon = {
        provider = function()
            return " "
        end,
        condition = require("galaxyline.condition").check_git_workspace,
        highlight = { colors.green2, colors.black },
        --separator = "| ",
        --separator_highlight = {colors.gray2, colors.black, "bold"}
    }
}

gls.right[2] = {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.condition").check_git_workspace,
        highlight = { colors.green2, colors.black, "bold" },
    }
}

gls.right[3] = {
    BlockElement = {
        provider = function()
            return "▌"
        end,
        highlight = { colors.black, colors.black }
    }
}


gls.right[4] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = " ",
        highlight = { colors.green, colors.black }
    }
}

gls.right[5] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = " ",
        highlight = { colors.blue, colors.black }
    }
}

gls.right[6] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = "  ",
        highlight = { colors.red, colors.black },
    }
}

gls.right[7] = {
    RoundLeftElement2 = {
        provider = function()
            return ""
        end,
        highlight = { colors.purple, colors.black }
    }
}

gls.right[8] = {
    LineIcon = {
        provider = function()
            return "󰭸 "
        end,
        highlight = { colors.black, colors.purple }
    },
}

gls.right[9] = {
    LineInfo = {
        provider = "LineColumn",
        highlight = { colors.black, colors.purple, "bold" },
    },
}

gls.right[10] = {
    RoundRightElement3 = {
        provider = function()
            return " "
        end,
        highlight = { colors.purple, colors.black }
    }
}

gls.right[11] = {
    line_percentage = {
        provider = function()
            local current_line = vim.fn.line(".")
            local total_line = vim.fn.line("$")

            if current_line == 1 then
                return " Top "
            elseif current_line == vim.fn.line("$") then
                return " Bottom "
            end
            local result, _ = math.modf((current_line / total_line) * 100)
            return "" .. result .. "% "
        end,
        highlight = { colors.orange, colors.black, "bold" },

    }
}

--gls.right[10] = {
--    RoundRightElement4 = {
--        provider = function()
--            return " "
--        end,
--        highlight = {colors.orange, colors.black}
--    }
--}

--gls.right[11] = { -- file size
--	FileSize = {
--		provider = require("galaxyline.providers.fileinfo").get_file_size,
--        highlight = {colors.gray2, colors.black}
--	},
--}
