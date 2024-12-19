return {
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    config = function()
      require("lspconfig").lua_ls.setup({})
      require("lspconfig").biome.setup({})
      require("lspconfig").vtsls.setup({})
      require("lspconfig").tailwindcss.setup({})
      require("lspconfig").ember.setup({})
      require("lspconfig").intelephense.setup({})
      require("lspconfig").basedpyright.setup({})
      -- require("plugins.lspconfig.intelephense")
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      bind = true,
      handler_opts = {
        border = "rounded",
      },
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
}
