if true then
  return {}
end
return {
  {
    "nvimtools/none-ls.nvim",
    enabled = true,
    branch = "main",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    opts = function(_, opts)
      local on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end

      opts.on_attach = on_attach

      local nls = require("null-ls")
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

        -- psaml
        require("lspconfig").psalm.setup({
          cmd = { "psalm", "--language-server" },
          cmd_env = {
            PATH = vim.env.PATH .. ":" .. vim.fn.getcwd() .. "/vendor/bin",
          },
          -- cmd = { "vendor/bin/psalm.phar", "--language-server" },
          -- args = {"--issues=MissingReturnType", "--ignore-issues=UnusedVariable" },
        }),

        -- format
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

        nls.builtins.formatting.duster.with({
          prefer_local = "vendor/bin",
        }),

        nls.builtins.formatting.xmllint,
        nls.builtins.formatting.prettierd,
      })
    end,
  },
}
