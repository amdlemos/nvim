if true then
  return {}
end
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
      dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter"
      },
      adapters = {
        require("neotest-pest")({
          -- sail_executable = "vendor/bin/sail",
          -- sail_project_path = "./",
          -- sail_enabled = true,
          -- pest_cmd = "vendor/bin/pest",
          -- results_path = function()
          --   return "storage/app/" .. os.date("junit-%Y%m%d-%H%M%S")
          -- end,
          --
          -- root_files = { ".git" }
        }),
      },
    })

    vim.keymap.set("n", "<leader>nn", function()
      require("neotest").run.run()
    end)
    vim.keymap.set("n", "<leader>nd", function()
      require("neotest").run.run({ strategy = "dap" })
    end)
  end,
}
