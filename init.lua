-- Adapted from NvChad
local init_files = {
    "options",
    "keymaps",
    "colors.highlights",
    "plugins.pluginList",
}

for _, file in ipairs(init_files) do
   local ok, err = pcall(require, file)
   if not ok then
      error("Error loading file" .. file .. "\n\n" .. err)
   end
end
