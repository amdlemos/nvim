-- vim.opt.relativenumber = true

-- Configuração global (aplica para todos os arquivos)
-- vim.opt.expandtab = true -- Converte tabs em espaços
-- vim.opt.shiftwidth = 2 -- Número de espaços para cada nível de indentação
-- vim.opt.tabstop = 2 -- Número de espaços que um tab representa

-- vim.opt.conceallevel = 0
-- vim.opt.concealcursor = ""
--
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Para Tree-sitter
--
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local options = {

  -- user interface

  mouse = "", -- disable mouse in neovim
  clipboard = "unnamedplus", -- neovim uses the system clipboard by default
  cursorline = true,
  showtabline = 0, -- hide tabline
  inccommand = "split", -- when performing substitution, show preview at the bottom
  timeoutlen = 300, -- time for user to finish a key combination
  updatetime = 200, -- faster completion
  virtualedit = "block", -- enable highlighting empty spaces
  splitbelow = true, -- when splitting horizontally, new window goes below
  splitright = true, -- when splitting vertically, new window goes to the right
  showmode = false, -- mode will be shown by statusline

  -- tabs and indentations

  expandtab = true, -- convert tabs into spaces
  shiftwidth = 2, -- the number of spaces for each indentation
  tabstop = 2, -- the number of spaces for each tab

  -- number columns

  relativenumber = true, -- display relative line numbers
  number = true, -- display the current line number
  numberwidth = 4, -- the column width to display line numbers

  -- text display

  foldlevelstart = 99, -- start with everything unfolded
  foldtext = "", -- keep the appearance of the first folded line

  wrap = false, -- do not wrap lines because it is ugly
  smartindent = true, -- automatic indentations
  scrolloff = 99, -- keep cursorline in the middle
  sidescrolloff = 6, -- minimul number of columns to the left and right of cursor

  fillchars = {
    eob = " ", -- removes annoying tilde at the bottom of short files
    fold = "-", -- replace dots with horizontal line to indicate folded sections
    vert = " ",
  },

  -- text search

  ignorecase = true, -- make search case-insensitive
  smartcase = true, -- but if our search contains uppercase(s), it becomes case-sensitive

  -- miscellaneous

  backup = false, -- do not create a backup file
  swapfile = false, -- do not create a swap file
  fileencoding = "utf-8", -- the encoding written to a file
}

for parameter, value in pairs(options) do
  vim.opt[parameter] = value
end