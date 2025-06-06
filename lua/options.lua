local set = vim.opt
local let = vim.g

set.encoding = "utf-8"
set.fileencodings = "utf-8"

set.clipboard = 'unnamedplus'

set.termguicolors = true

set.cursorline = true

let.mapleader = " "

set.showtabline = 2

-- Indenting
set.expandtab = true
set.shiftwidth = 4 -- number of spaces which compose the 'tab' action
set.smartindent = true
set.tabstop = 4
set.softtabstop = 4

set.smartcase = true

set.wrap = false

-- lines
set.relativenumber = true
set.nu = true
set.scrolloff = 8

-- other
set.hlsearch = false
set.incsearch = true
set.hidden = true
set.signcolumn = "yes"
set.colorcolumn = "80,100"

-- history
set.swapfile = false
set.backup = false
set.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
set.undofile = true

-- set linewidth for certain files
vim.api.nvim_exec([[
    autocmd BufRead,BufNewFile *.tex setlocal textwidth=120
    ]], false)

-- set spelling check
vim.api.nvim_exec([[
    autocmd BufRead,BufNewFile *.md setlocal spell
    autocmd BufRead,BufNewFile *.rmd setlocal spell
    autocmd BufRead,BufNewFile *.tex setlocal spell
    ]], false)

set.spelllang = "en_us"

-- languagetool
let.languagetool_lang = "en-US"
let.languagetool_jar =
"/usr/share/java/languagetool/languagetool-commandline.jar" -- if languagetool is installed from the AUR is always this path

-- Dashboard
let.indentLine_fileTypeExclude = "dashboard"

vim.api.nvim_exec([[
    autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2
    ]], false)

-- LaTeX PDF previews
let.latex_pdf_viewer = "zathura"
let.latex_engine = "xelatex"

-- LaTeX settings (I do not how how to write 'au' in lua bc I'm stupid)
vim.api.nvim_exec([[
    autocmd BufNewFile,BufRead *.tex set nocursorline
    autocmd BufNewFile,BufRead *.tex set nornu
    autocmd BufNewFile,BufRead *.tex set number
    autocmd BufNewFile,BufRead *.tex let g:loaded_matchparen=1
    autocmd BufNewFile,BufRead *.tex set noshowmatch
    autocmd BufNewFile,BufRead *.tex set conceallevel=0
    ]], false)

let.vimtex_view_method = "zathura"
let.vimtex_compiler_method = "latexmk"

-- This will yank to your local clipboard whenever you yank in normal/visual mode
vim.api.nvim_exec([[
  augroup OscYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' && v:event.regname == '' | execute 'OSCYankRegister "' | endif
  augroup END
]], false)

return M
