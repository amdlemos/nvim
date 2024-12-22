vim.g["diagnostics_active"] = true
function Toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    -- vim.diagnostic.disable()
  else
    vim.g.diagnostics_active = true
    vim.diagnostic.enable()
  end
end

vim.keymap.set(
  "n",
  "<leader>xd",
  Toggle_diagnostics,
  { noremap = true, silent = true, desc = "Toggle vim diagnostics" }
)

vim.cmd("colorscheme astromars")
vim.cmd("set termguicolors")

-- Atualiza automaticamente arquivos alterados externamente
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  command = "checktime",
})

-- Função para alternar entre os temas
function ToggleTheme()
  if vim.o.background == "light" then
    vim.o.background = "dark"
    vim.cmd("colorscheme astromars") -- Mude para o tema escuro
  else
    vim.o.background = "light"
    vim.cmd("colorscheme astrojupiter") -- Mude para o tema claro
  end
end

-- Mapeie a função a um comando
vim.api.nvim_create_user_command("ToggleTheme", ToggleTheme, {})
-- Mapeamento de tecla (ex: Ctrl + t para alternar o tema)
vim.api.nvim_set_keymap(
  "n",
  "<C-t>",
  ":ToggleTheme<CR>",
  { noremap = true, silent = true }
)

vim.diagnostic.config({
  virtual_text = false,
})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup(
    "kickstart-highlight-yank",
    { clear = true }
  ),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- function _G.set_terminal_keymaps()
--   local opts = { buffer = 0 }
--   vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  -- vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  -- vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  -- vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  -- vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  -- vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  -- vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
-- end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
-- vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
