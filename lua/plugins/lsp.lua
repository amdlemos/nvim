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
        "intelephense",
        -- "tailwindcss",
        -- "ember",
        -- "basedpyright",
      }
      for _, lsp in ipairs(servers) do
        require("lspconfig")[lsp].setup({
          capabilities = capabilities,
          on_attach = function(client)
            print(
              string.format(
                "LSP %s iniciado com encoding: %s",
                client.name,
                client.server_capabilities.positionEncoding or "não definido"
              )
            )
          end,
        })
      end
      -- require("lspconfig").lua_ls.setup({})
      -- require("lspconfig").biome.setup({})
      -- require("lspconfig").vtsls.setup({})
      -- require("lspconfig").tailwindcss.setup({})
      -- require("lspconfig").ember.setup({})
      -- require("lspconfig").intelephense.setup({})
      -- require("lspconfig").basedpyright.setup({})
      -- require("plugins.lspconfig.intelephense")
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      bind = true,
      handler_opts = {
        -- border = "rounded",
      },
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
}
