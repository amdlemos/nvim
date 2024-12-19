return {
  "mfussenegger/nvim-lint",
  enabled = true,
  event = { "BufReadPre", "BufWritePost", "BufReadPost" },
  init = function()
    vim.api.nvim_create_autocmd(
      { "BufWritePost", "BufReadPost", "BufReadPre" },
      {
        callback = function()
          require("lint").try_lint()
        end,
      }
    )
  end,
  config = function()
    local lint = require("lint")
    local phpmd = lint.linters.phpmd
    phpmd.args = {
      "-",
      "json",
      "phpmd.xml",
    }

    lint.linters_by_ft = {
      php = { "phpmd" },
    }
  end,
}
