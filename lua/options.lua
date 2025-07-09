local set = vim.opt
local let = vim.g
local exec = vim.api.nvim_exec

set.encoding = "utf-8"
set.fileencodings = "utf-8"
set.clipboard = 'unnamedplus'
set.termguicolors = true
set.cursorline = true
let.mapleader = " "
set.showtabline = 2
set.smartcase = true
set.spelllang = "en_us"
--set.wrap = false

-- Dashboard
let.indentLine_fileTypeExclude = "dashboard"

-- go to previous/next line when cursor reaches end/beginning of line
set.whichwrap:append "<>[]hl"

-- disable some default providers
let.loaded_node_provider = 0
let.loaded_python3_provider = 0
let.loaded_perl_provider = 0
let.loaded_ruby_provider = 0

-- Indenting
set.expandtab = true
set.shiftwidth = 4 -- number of spaces which compose the 'tab' action
set.smartindent = true
set.tabstop = 4
set.softtabstop = 4

-- Color columns for python and/or latex
set.colorcolumn = "80,120"

-- lines
set.relativenumber = true
set.nu = true
set.scrolloff = 8

-- other
set.hlsearch = false
set.incsearch = true
set.hidden = true
set.signcolumn = "yes"

-- history
set.swapfile = false
set.backup = false
set.undodir = os.getenv("HOME") .. "/.nvim_undodir"
set.undofile = true

-- Clipboard 
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("OscYank", { clear = true }),
  callback = function()
    if vim.v.event.operator == "y" and vim.v.event.regname == "" then
      vim.cmd('OSCYankRegister "')
    end
  end,
})

-- LaTeX settings (I do not how how to write 'au' in lua bc I'm stupid)
-- LaTeX PDF previews
let.vimtex_view_method = "zathura"
let.vimtex_compiler_method = "latexmk"
let.latex_pdf_viewer = "zathura"
let.latex_engine = "xelatex"

exec([[
    autocmd BufNewFile,BufRead *.tex set nocursorline
    autocmd BufNewFile,BufRead *.tex set nornu
    autocmd BufNewFile,BufRead *.tex set number
    autocmd BufNewFile,BufRead *.tex let g:loaded_matchparen=1
    autocmd BufNewFile,BufRead *.tex set noshowmatch
    autocmd BufNewFile,BufRead *.tex set conceallevel=0
    autocmd BufRead,BufNewFile *.tex setlocal textwidth=120
    autocmd BufRead,BufNewFile *.tex setlocal spell
    ]], false
)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dashboard",
  callback = function()
    vim.o.showtabline = 0
    vim.api.nvim_create_autocmd("WinLeave", {
      buffer = 0,
      once = true,
      callback = function()
        vim.o.showtabline = 2
      end,
    })
  end,
})

-- Third party stuff
-- languagetool
let.languagetool_lang = "en-US"
let.languagetool_jar = "/usr/share/java/languagetool/languagetool-commandline.jar"

