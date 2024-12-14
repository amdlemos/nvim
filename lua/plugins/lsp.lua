return {
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    config = function()
      require("lspconfig").lua_ls.setup({})
      require("lspconfig").biome.setup({})
      require("lspconfig").vtsls.setup({})
      -- require("lspconfig").tailwindcss.setup({})
      require("lspconfig").ember.setup({})
      require("plugins.lspconfig.intelephense")
      -- vim.api.nvim_set_keymap(
      --   "n",
      --   "<leader>ca",
      --   "<cmd>lua vim.lsp.buf.code_action()<CR>",
      --   { noremap = true, silent = true }
      -- )
    end,
  },
}
