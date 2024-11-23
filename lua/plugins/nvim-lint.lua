if true then
  return {}
end
return {
  "mfussenegger/nvim-lint",
  config = function()
    require("lint").linters_by_ft = {
      php = { "phpstan", "phpcs", "phpmd" },
    }

    local phpstan = require("lint").linters.phpstan
    phpstan.cmd = "src/vendor/bin/phpstan"

    local phpcs = require("lint").linters.phpcs
    phpcs.cmd = "src/vendor/bin/phpcs"
    phpcs.args = {
      "-q",
      "--report=json",
      "--standard=src/.phpcs.xml",
      "-",
    }

    local phpmd = require("lint").linters.phpmd
    phpmd.cmd = "src/vendor/bin/phpmd"
    phpmd.args = {
      "-",
      "json",
      "src/rulesets.xml",
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })

    -- Autocomando para executar o lint ao entrar no arquivo
    vim.api.nvim_create_autocmd({ "BufReadPost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
