local theme_name = require("colors.theme").ui.theme
local highlights_path = "colors.themes." .. theme_name .. ".highlights"

local ok, highlights = pcall(require, highlights_path)
if ok then
    highlights()
else
    vim.notify("Failed to load highlights for theme: " .. theme_name, vim.log.levels.ERROR)
end

-- Source other files
local init_files = {
    "options",
    "keymaps",
    "config.lazy",
    "config.lsp",
    "config.statusline",
    "config.tabline",
}

for _, file in ipairs(init_files) do
    local ok, err = pcall(require, file)
    if not ok then
        error("Error loading file: " .. file .. "\n\n" .. err)
    end
end
