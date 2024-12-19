
if true then
  return {}
end
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
          require("lint").try_lint("rectorphp")
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
    -- Função auxiliar para extrair o número da linha do diff
    -- local function extract_line_from_diff(diff)
    --   -- Procura pelo padrão @@ -X,Y +X,Y @@ no diff
    --   local line_info = diff:match("@@ %-(%d+),?%d* %+(%d+),?%d* @@")
    --   return line_info and tonumber(line_info) or 0
    -- end
    --
    -- lint.linters.rectorphp = {
    --   cmd = "vendor/bin/rector",
    --   stdin = false, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
    --   append_fname = true, -- Automatically append the file name to `args` if `stdin = false` (default: true)
    --   args = { "process", "--dry-run", "--output-format=json" }, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
    --   stream = "stdout", -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
    --   ignore_exitcode = true, -- set this to true if the linter exits with a code != 0 and that's considered normal.
    --   env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
    --   parser = function(output, bufnr)
    --     if vim.trim(output) == "" or output == nil then
    --       return {}
    --     end
    --
    --     local decoded = vim.json.decode(output)
    --     if not decoded or not decoded.file_diffs then
    --       return {}
    --     end
    --
    --     local diagnostics = {}
    --     local current_file = vim.api.nvim_buf_get_name(bufnr)
    --
    --     for _, file_diff in ipairs(decoded.file_diffs) do
    --       -- Verifica se o diff corresponde ao arquivo atual
    --       if
    --         vim.fn.fnamemodify(current_file, ":t")
    --         == vim.fn.fnamemodify(file_diff.file, ":t")
    --       then
    --         local line_num = extract_line_from_diff(file_diff.diff)
    --
    --         for _, rector in ipairs(file_diff.applied_rectors) do
    --           -- Extrai o nome curto do Rector (última parte após \\)
    --           local short_name = rector:match("([^\\]+)$") or rector
    --
    --           table.insert(diagnostics, {
    --             lnum = line_num - 1, -- -1 porque o Neovim usa base 0
    --             col = 0,
    --             message = "Applied: " .. short_name,
    --             severity = vim.diagnostic.severity.INFO,
    --             source = "rector",
    --           })
    --         end
    --       end
    --     end
    --
    --     return diagnostics
    --   end,
    -- }
    --
    -- lint.root_patterns_by_ft = {
    --   php = {
    --     rectorphp = { "rector.php" },
    --   },
    -- }

    lint.linters_by_ft = {
      php = { "phpmd", "rectorphp" },
    }
  end,
}
