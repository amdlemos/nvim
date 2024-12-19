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

        -- phpmd
        -- nls.builtins.diagnostics.phpmd.with({
        --   prefer_local = "vendor/bin",
        --   args = { '-',  'json', 'phpmd.xml' }
        -- }),

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

        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.xmllint,
        nls.builtins.formatting.prettier,
        nls.builtins.formatting.stylua,
        -- nls.builtins.formatting.prettierd,
      })
    end,
  },
}
