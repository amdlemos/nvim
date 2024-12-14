return {
  "nvimdev/lspsaga.nvim",
  enabled = true,
  lazy = false,
  keys = {
    { "<leader>l", "", desc = "Lsp" },
    { "<leader>la", "<cmd>Lspsaga code_action<cr>", desc = "Code Action (LspSaga)" },
    { "<Leader>lS", "<Cmd>Lspsaga outline<CR>", desc = "Symbols outline (LspSaga)" },
    { "<Leader>lr", "<Cmd>Lspsaga rename<CR>", desc = "Rename current symbol (LspSaga)" },
    {
      "<leader>lp",
      "<cmd>Lspsaga peek_definition<cr>",
      desc = "Peek Definition (LspSaga)",
    },
    {
      "<leader>lg",
      "<cmd>Lspsaga goto_definition<cr>",
      desc = "Goto Definition (LspSaga)",
    },
    {
      "<leader>lt",
      "<cmd>Lspsaga term_toggle<cr>",
      desc = "Toogle Term (LspSaga)",
    },
    {
      "<leader>ld",
      "<cmd>Lspsaga hover_doc<cr>",
      desc = "Hover Doc (LspSaga)",
    },
  },
  config = function()
    require("lspsaga").setup({
      winbar = {
        enable = true,
      },
      symbol_in_winbar = {
        enable = false,
      },
      diagnostic = {
        diagnostic_only_current = true,
      },
      -- ui = {
      --   code_action = "??",
      --   enable = true,
      --   sign = true,
      --   virtual_text = true,
      -- },
    })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    -- "nvim-tree/nvim-web-devicons", -- optional
  },
}
