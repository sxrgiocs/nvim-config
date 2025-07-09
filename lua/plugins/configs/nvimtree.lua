vim.o.termguicolors = true

local nvim_tree = require("nvim-tree")


nvim_tree.setup({
    disable_netrw = true,
    hijack_netrw = false,
    update_cwd = true,
    view = {
        side = "left",
        width = 30,
        preserve_window_proportions = true,
    },
    renderer = {
        add_trailing = false,
        group_empty = true,
        highlight_git = true,
        highlight_opened_files = "none",
        indent_markers = {
            enable = true,
        },
        icons = {
            show = {
                git = true,
                folder = true,
                file = true,
            },
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌",
                },
                folder = {
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
            },
        },
        root_folder_label = ":t",
    },
    filters = {
        dotfiles = true,
        custom = { ".git", "node_modules", ".cache" },
    },
    git = {
        enable = true,
        ignore = true,
    },
    actions = {
        open_file = {
            quit_on_open = false,
        },
    },
    tab = {
        sync = {
            open = false,
        },
    },
    diagnostics = {
        enable = false,
    },
    respect_buf_cwd = true,
    on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        local keymap = vim.keymap.set
        keymap("n", "<CR>", api.node.open.edit, opts("Open"))
        keymap("n", "o", api.node.open.edit, opts("Open"))
        keymap("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
        keymap("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
        keymap("n", "q", api.tree.close, opts("Close"))
        keymap("n", "R", api.tree.reload, opts("Refresh"))
        keymap("n", "a", api.fs.create, opts("Create"))
        keymap("n", "d", api.fs.remove, opts("Delete"))
        keymap("n", "r", api.fs.rename, opts("Rename"))
        keymap("n", "x", api.fs.cut, opts("Cut"))
        keymap("n", "c", api.fs.copy.node, opts("Copy"))
        keymap("n", "p", api.fs.paste, opts("Paste"))
        keymap("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
        keymap("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
    end,
})

-- Optional: hide statusline when NvimTree is open
-- vim.cmd([[
--   augroup NvimTreeStatusline
--     autocmd!
--     autocmd BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
--   augroup END
-- ]])
