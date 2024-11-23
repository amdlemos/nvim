return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").biome.setup({})
      require("lspconfig").tailwindcss.setup({})
      require("plugins.lspconfig.intelephense")
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ca",
        "<cmd>lua vim.lsp.buf.code_action()<CR>",
        { noremap = true, silent = true }
      )
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    opts = function(_, opts)

      local on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
                  group = augroup,
            buffer = bufnr,
            callback = function()
                      vim.lsp.buf.format({ bufnr = bufnr })
            end,
              })
          end
      end
      local nls = require("null-ls")
      -- opts.default_timeout = 10000000000
      opts.on_attach = on_attach
      opts.root_dir = opts.root_dir
        or require("null-ls.utils").root_pattern(
          ".null-ls-root",
          "composer.json",
          ".neoconf.json",
          "Makefile",
          ".git"
        )
      opts.sources = vim.list_extend(opts.sources or {}, {
        --phpstan
        nls.builtins.diagnostics.phpstan.with({
          prefer_local = "vendor/bin",
        }),

        -- phpcs
        nls.builtins.diagnostics.phpcs.with({
          prefer_local = "vendor/bin",
        }),

        -- phpmd
        nls.builtins.diagnostics.phpmd.with({
          prefer_local = "vendor/bin",
          args = {
            "$FILENAME",
            "json",
            "rulesets.xml",
            -- "--exclude",
            -- "vendor",
          },
        }),

        -- psaml
        require("lspconfig").psalm.setup({
          cmd = { "vendor/bin/psalm.phar", "--language-server"},
          -- args = {"--issues=MissingReturnType", "--ignore-issues=UnusedVariable" },
        }),

        -- phpcsfixer
        nls.builtins.formatting.phpcsfixer.with({
          prefer_local = "vendor/bin",
        }),

        -- phpcbf
        nls.builtins.formatting.phpcbf.with({
          prefer_local = "vendor/bin",
          extra_args = { "--no-php-ini" },
        }),

        -- pint
        nls.builtins.formatting.pint.with({
          prefer_local = "vendor/bin",
        }),

        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.xmllint,
        nls.builtins.formatting.stylua,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    enabled = false,
  },
  {
    "stevearc/conform.nvim",
    enabled = false,
  },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   enabled = false,
  -- },
}
