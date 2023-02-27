-- define the files that will be sourced
local init_files = {
    'options',
    'keymaps',
    'colors.highlights',
    'plugins.pluginList',
    'plugins.init',
}

-- quick troubleshoot: load the file except when it has some errors
for _, file in ipairs(init_files) do
   local ok, err = pcall(require, file)
   if not ok then
      error('Error loading file' .. file .. '\n\n' .. err)
   end
end
