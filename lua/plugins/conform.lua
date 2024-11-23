if true then
  return {}
end
return {
  "stevearc/conform.nvim",
  config = function()
    local util = require("conform.util")
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        xml = { "xmllint" },
        yaml = { "prettier" },
        php = {
          "pint",
          -- "php_cs_fixer",
          -- "phpcbf",
          stop_after_first = true,
        },
        css = { "prettied", "prettier", stop_after_first = true },
        graphql = { "prettied", "prettier", stop_after_first = true },
        html = { "prettied", "prettier", stop_after_first = true },
        javascript = { "prettied", "prettier", stop_after_first = true },
        javascriptreact = { "prettied", "prettier", stop_after_first = true },
        json = { "prettied", "prettier", stop_after_first = true },
        markdown = { "prettied", "prettier", stop_after_first = true },
        python = { "isort", "black", stop_after_first = true },
        sql = { "sql-formatter" },
        svelte = { "prettied", "prettier", stop_after_first = true },
        typescript = {
          "prettied",
          "prettier",
          "sql-formatter",
          stop_after_first = true,
        },
        typescriptreact = { "prettied", "prettier", stop_after_first = true },
        yaml = { "prettier" },
      },
      formatters = {
        pint = {
          append_args = {
            "--config",
            "src/pint.json",
          },
        },
        -- php_cs_fixer = {
        --   command = util.find_executable({
        --     "tools/php-cs-fixer/vendor/bin/php-cs-fixer",
        --     "vendor/bin/php-cs-fixer",
        --     "src/vendor/bin/php-cs-fixer",
        --   }, "php-cs-fixer"),
        --   append_args = {
        --     "--config=.php-cs-fixer.dist.php",
        --     "--allow-risky=yes",
        --   },
        -- },
        -- phpcbf = {
        --   command = util.find_executable({
        --     "tools/phpcbf/vendor/bin/phpcbf",
        --     "vendor/bin/phpcbf",
        --     "src/vendor/bin/phpcbf",
        --   }, "phpcbf"),
        -- },
      },
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf })
      end,
    })
    -- require("conform").formatters.php_cs_fixer = {
    --   inherit = false,
    --   command = "shfmt",
    --   args = { "-i", "2", "-filename", "$FILENAME" },
    -- }

    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   pattern = "*",
    --   callback = function(args)
    --     require("conform").format({
    --       bufnr = args.buf,
    --       async = true,
    --       lsp_fallback = true,
    --     })
    --   end,
    -- })
  end,
}
