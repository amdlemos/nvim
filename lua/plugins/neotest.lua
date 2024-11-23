return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "V13Axel/neotest-pest",
  },
  config = function()
    require("neotest").setup({
      log_level = vim.log.levels.DEBUG,
      adapters = {
        require("neotest-pest")({
          sail_executable = "src/vendor/bin/sail",
          sail_project_path = "/var/www/html",
          sail_enabled = true,
          -- pest_cmd = "vendor/bin/pest",
          results_path = function()
            return "storage/app/" .. os.date("junit-%Y%m%d-%H%M%S")
          end,

          root_files = { ".git" }
        }),
      },
    })

    vim.keymap.set("n", "<leader>nn", function()
      require("neotest").run.run()
    end)
  end,
}
