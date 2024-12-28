return {
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.positionEncoding = "utf-8"

      local servers = {
        "vtsls",
        "lua_ls",
        "biome",
        -- "intelephense",
        -- "tailwindcss",
        -- "ember",
        -- "basedpyright",
      }
      for _, lsp in ipairs(servers) do
        require("lspconfig")[lsp].setup({
          capabilities = capabilities,
        })
      end
      require("lspconfig").intelephense.setup({
        capabilities = capabilities,
        settings = {
          intelephense = {
            environment = {
              phpVersion = "8.3",
            },
          },
        },
      })
      require("lspconfig").clangd.setup({
        cmd = { "clangd" },
        filetypes = { "mql", "mq4", "mq5" },
        -- root_dir = lspconfig.util.root_pattern(".git"),
      })
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
