return {
  "stevearc/conform.nvim",
  enabled = true,
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        -- php = {
        --   "easy-coding-standard",
        --   stop_after_first = true,
        -- },
      },
      -- formatters = {
      -- injected = { options = { ignore_errors = true } },
      -- # Example of using dprint only when a dprint.json file is present
      -- dprint = {
      --   condition = function(ctx)
      --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
      --   end,
      -- },
      -- },
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf, timeout = 1000000 })
      end,
    })
  end,
}
