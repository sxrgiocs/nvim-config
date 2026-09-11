local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- VIM hard mode
map("n", "<Left>", "", { noremap = true })
map("i", "<Left>", "", { noremap = true })
map("c", "<Right>", "", { noremap = true })
map("n", "<Right>", "", { noremap = true })
map("i", "<Right>", "", { noremap = true })
map("c", "<Right>", "", { noremap = true })
map("n", "<Up>", "", { noremap = true })
map("i", "<Up>", "", { noremap = true })
map("c", "<Up>", "", { noremap = true })
map("n", "<Down>", "", { noremap = true })
map("i", "<Down>", "", { noremap = true })
map("c", "<Down>", "", { noremap = true })

-- Save file by hitting double escape
-- map("i", "<esc><esc>", "<esc>:w<cr>", { noremap = true })

-- Buffers
map("n", "<C-H>", ":bprev<CR>", { noremap = true })
map("n", "<C-L>", ":bnext<CR>", { noremap = true })

-- Snacks Explorer (Filetree)
map("n", "<leader>t", function()
    local bufname = vim.api.nvim_buf_get_name(0)
    local dir = nil
    if bufname ~= "" and vim.bo.buftype == "" then
        dir = vim.fs.dirname(bufname)
    end
    Snacks.explorer({ cwd = dir or vim.fn.getcwd() })
end, { desc = "Toggle Snacks Explorer (buffer dir)" })

-- Ranger
map("n", "<leader>r", ":Ranger<CR>", {})

map("n", "<C-z>", "<Nop>", {})

-- Resize splits
map("", "<leader>=", ":vertical resize +5<CR>", {})
map("", "<leader>-", ":vertical resize -5<CR>", {})
map("", "<leader>+", ":res -5<CR>", {})
map("", "<leader>_", ":res +5<CR>", {})

-- LaTeX preview
map("", "<leader>p", ":VimtexCompile<CR>", { noremap = true })

-- Numbers
map("n", "<leader>n", ":set relativenumber!<CR>", {})

-- Telescope
map("n", "<leader>fb", ":Telescope buffers<CR>", {})
map("n", "<leader>ff", ":Telescope find_files hidden=true<CR>")
map("n", "<leader>fgc", ":Telescope git_commits<CR>", {})
map("n", "<leader>fgs", ":Telescope git_status<CR>", {})
map("n", "<leader>fo", ":Telescope oldfiles<CR>", {})

--Dashboard
map("n", "<leader>fn", ":DashboardNewFile", {})
map("n", "<leader>d", ":Dashboard<CR>", {})

map("n", "\\lc", ":VimtexStop<cr>:VimtexClean<cr>")

map('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
