-- ---------------------------------------------------------------------------
-- Automatic Buffer Change Highlighter (External & AI Agent modifications)
-- ---------------------------------------------------------------------------

vim.opt.autoread = true
vim.opt.updatetime = 300

local change_ns = vim.api.nvim_create_namespace("external_buffer_change_highlight")
local base_snapshots, watchers = {}, {}


-- Dynamically load and blend colors from the user's active theme
local function blend_hex(fg, bg, alpha)
    if not fg or not bg or not string.match(fg, "^#%x%x%x%x%x%x$") or not string.match(bg, "^#%x%x%x%x%x%x$") then
        return fg
    end
    local r1, g1, b1 = tonumber(fg:sub(2, 3), 16), tonumber(fg:sub(4, 5), 16), tonumber(fg:sub(6, 7), 16)
    local r2, g2, b2 = tonumber(bg:sub(2, 3), 16), tonumber(bg:sub(4, 5), 16), tonumber(bg:sub(6, 7), 16)
    local r = math.floor(r1 * alpha + r2 * (1 - alpha) + 0.5)
    local g = math.floor(g1 * alpha + g2 * (1 - alpha) + 0.5)
    local b = math.floor(b1 * alpha + b2 * (1 - alpha) + 0.5)
    return string.format("#%02x%02x%02x", r, g, b)
end


local function setup_theme_highlights()
    local theme_name = require("colors.theme").ui.theme
    local colors = require("colors.themes." .. theme_name .. ".colors")

    local bg = colors.background
    local green_fg = colors.green2 or colors.green
    local blue_fg = colors.blue2 or colors.blue
    local red_fg = colors.red2 or colors.red

    local green_bg = blend_hex(green_fg, bg, 0.15)
    local blue_bg = blend_hex(blue_fg, bg, 0.15)
    local red_bg = blend_hex(red_fg, bg, 0.18)

    vim.api.nvim_set_hl(0, "BufferChangeAdd",     { fg = green_fg, bold = true })
    vim.api.nvim_set_hl(0, "BufferChangeMod",     { fg = blue_fg, bold = true })
    vim.api.nvim_set_hl(0, "BufferChangeDel",     { fg = red_fg, bold = true })

    vim.api.nvim_set_hl(0, "BufferChangeLineAdd", { bg = green_bg })
    vim.api.nvim_set_hl(0, "BufferChangeLineMod", { bg = blue_bg })
    vim.api.nvim_set_hl(0, "BufferChangeLineDel", { bg = red_bg, fg = red_fg })
end
setup_theme_highlights()


local function get_buf_content(bufnr)
    if not vim.api.nvim_buf_is_valid(bufnr) then return nil, {} end
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    return table.concat(lines, "\n") .. (#lines > 0 and "\n" or ""), lines
end


local function clear_highlights(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_clear_namespace(bufnr, change_ns, 0, -1)
        pcall(vim.keymap.del, "n", "<CR>", { buffer = bufnr })
        base_snapshots[bufnr] = get_buf_content(bufnr)
    end
end


local function apply_diff_highlights(bufnr)
    if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= "" then return end
    local cur_text, cur_lines = get_buf_content(bufnr)
    local base_text = base_snapshots[bufnr]

    if not base_text or base_text == cur_text then
        return clear_highlights(bufnr)
    end

    local base_lines = vim.split(base_text, "\n", { plain = true })
    if #base_lines > 0 and base_lines[#base_lines] == "" then table.remove(base_lines) end
    vim.api.nvim_buf_clear_namespace(bufnr, change_ns, 0, -1)
    local changes = 0

    vim.diff(base_text, cur_text, {
        result_type = "indices",
        on_hunk = function(start_a, count_a, start_b, count_b)
            if count_a == 0 and count_b > 0 then
                -- Pure Addition: Green
                for i = 0, count_b - 1 do
                    local line = (start_b > 0 and (start_b - 1) or 0) + i
                    if line < #cur_lines then
                        changes = changes + 1
                        vim.api.nvim_buf_set_extmark(bufnr, change_ns, line, 0, {
                            sign_text = "▎",
                            sign_hl_group = "BufferChangeAdd",
                            line_hl_group = "BufferChangeLineAdd",
                            number_hl_group = "BufferChangeAdd",
                            priority = 100,
                        })
                    end
                end
            elseif count_a > 0 and count_b > 0 then
                -- Modification: Blue for modified lines, Green for any extra added lines
                local mod_count = math.min(count_a, count_b)
                for i = 0, mod_count - 1 do
                    local line = (start_b > 0 and (start_b - 1) or 0) + i
                    if line < #cur_lines then
                        changes = changes + 1
                        vim.api.nvim_buf_set_extmark(bufnr, change_ns, line, 0, {
                            sign_text = "▎",
                            sign_hl_group = "BufferChangeMod",
                            line_hl_group = "BufferChangeLineMod",
                            number_hl_group = "BufferChangeMod",
                            priority = 100,
                        })
                    end
                end
                if count_b > count_a then
                    for i = count_a, count_b - 1 do
                        local line = (start_b > 0 and (start_b - 1) or 0) + i
                        if line < #cur_lines then
                            changes = changes + 1
                            vim.api.nvim_buf_set_extmark(bufnr, change_ns, line, 0, {
                                sign_text = "▎",
                                sign_hl_group = "BufferChangeAdd",
                                line_hl_group = "BufferChangeLineAdd",
                                number_hl_group = "BufferChangeAdd",
                                priority = 100,
                            })
                        end
                    end
                end
                if count_a > count_b then
                    local virt_lines = {}
                    for i = count_b, count_a - 1 do
                        table.insert(virt_lines, {
                            { (base_lines[start_a + i] or "") .. string.rep(" ", 300), "BufferChangeLineDel" }
                        })
                    end
                    local target = math.max(0, math.min(start_b + count_b - 2, #cur_lines - 1))
                    changes = changes + 1
                    vim.api.nvim_buf_set_extmark(bufnr, change_ns, target, 0, {
                        sign_text = "▎",
                        sign_hl_group = "BufferChangeDel",
                        number_hl_group = "BufferChangeDel",
                        virt_lines = virt_lines,
                        virt_lines_above = false,
                        priority = 100,
                    })
                end
            elseif count_a > 0 and count_b == 0 then
                -- Pure Deletion: Red
                local virt_lines = {}
                for i = 0, count_a - 1 do
                    table.insert(virt_lines, {
                        { (base_lines[start_a + i] or "") .. string.rep(" ", 300), "BufferChangeLineDel" }
                    })
                end
                local target = (#cur_lines == 0 or start_b == 0) and 0 or math.min(start_b - 1, #cur_lines - 1)
                changes = changes + 1
                vim.api.nvim_buf_set_extmark(bufnr, change_ns, target, 0, {
                    sign_text = "▎",
                    sign_hl_group = "BufferChangeDel",
                    number_hl_group = "BufferChangeDel",
                    virt_lines = virt_lines,
                    virt_lines_above = (start_b == 0 and #cur_lines > 0),
                    priority = 100,
                })
            end
        end,
    })

    if changes > 0 and vim.api.nvim_buf_is_valid(bufnr) then
        vim.keymap.set("n", "<CR>", function() clear_highlights(bufnr) end, {
            buffer = bufnr, silent = true, nowait = true, desc = "Clear change highlights",
        })
    end
end


local function stop_watcher(bufnr)
    if watchers[bufnr] then
        watchers[bufnr]:stop()
        if not watchers[bufnr]:is_closing() then watchers[bufnr]:close() end
        watchers[bufnr] = nil
    end
end


local function watch_buffer(bufnr)
    if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= "" then return end
    local path = vim.api.nvim_buf_get_name(bufnr)
    if path == "" or not vim.uv.fs_stat(path) then return end

    if not base_snapshots[bufnr] then
        base_snapshots[bufnr] = get_buf_content(bufnr)
    end

    if not watchers[bufnr] then
        local poll = vim.uv.new_fs_poll()
        watchers[bufnr] = poll
        poll:start(path, 150, function(err)
            if err then return end
            vim.schedule(function()
                if vim.api.nvim_buf_is_valid(bufnr) and vim.fn.getcmdwintype() == "" then
                    pcall(vim.cmd, "silent! checktime " .. bufnr)
                end
            end)
        end)
    end
end


local grp = vim.api.nvim_create_augroup("ExternalBufferChangeHighlighter", { clear = true })

-- Update theme highlights if colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", { group = grp, callback = setup_theme_highlights })
-- Initialize baseline snapshot and watcher on open/enter
vim.api.nvim_create_autocmd({ "BufReadPost", "BufEnter" }, { group = grp, callback = function(a) watch_buffer(a.buf) end })
-- When saving locally in this Neovim window, update baseline and keep this active buffer clean
vim.api.nvim_create_autocmd("BufWritePost", { group = grp, callback = function(a) clear_highlights(a.buf) end })
-- Accept reload silently
vim.api.nvim_create_autocmd("FileChangedShell", { group = grp, callback = function() vim.v.fcs_choice = "reload" end })
-- Highlight external changes when reloaded from disk
vim.api.nvim_create_autocmd("FileChangedShellPost", { group = grp, callback = function(a) apply_diff_highlights(a.buf) end })
-- Clean up on buffer deletion
vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, { group = grp, callback = function(a)
    clear_highlights(a.buf)
    stop_watcher(a.buf)
    base_snapshots[a.buf] = nil
end })
-- Background checktime trigger on focus/idle
vim.api.nvim_create_autocmd({ "FocusGained", "CursorHold", "CursorHoldI" }, { group = grp, callback = function()
    if vim.fn.getcmdwintype() == "" then pcall(vim.cmd, "silent! checktime") end
end })
vim.api.nvim_create_user_command("ClearChangeHighlights", function()
    clear_highlights(vim.api.nvim_get_current_buf())
end, { desc = "Clear external buffer change highlights" })

return {
    clear = clear_highlights,
    watch = watch_buffer,
    apply = apply_diff_highlights,
}