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
    vim.cmd("colorscheme darcula-solid") -- Mude para o tema escuro
  else
    vim.o.background = "light"
    vim.cmd("colorscheme github_light_default") -- Mude para o tema claro
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
