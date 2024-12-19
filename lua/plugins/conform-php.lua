return {
  "stevearc/conform.nvim",
  enabled = true,
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        php = {
          "easy-coding-standard",
          stop_after_first = true,
        },
      },
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf, timeout = 1000000 })
      end,
    })
  end,
}
