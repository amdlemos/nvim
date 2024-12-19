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
vim.cmd("colorscheme astrodark")
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
    vim.cmd("colorscheme astrodark") -- Mude para o tema escuro
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
    virtual_text = false
})

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
