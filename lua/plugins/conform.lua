return {
  "stevearc/conform.nvim",
  enabled = true,
  config = function()
    require("conform").setup({
      log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {
        lua = { "stylua" },
        php = {
          "easy-coding-standard",
          -- stop_after_first = true,
        },
        json = { "prettier" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
        -- # Example of using ecs only when a ecs.php file is present
        easy_coding_standard = {
          condition = function(ctx)
            return vim.fs.find(
              { "ecs.php" },
              { path = ctx.filename, upward = true }
            )[1]
          end,
        },

        stylua = {
          condition = function(ctx)
            return vim.fs.find(
              { ".stylua.toml" },
              { path = ctx.filename, upward = true }
            )[1]
          end,
        },
      },
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf, timeout = 1000 })
      end,
    })
  end,
}
