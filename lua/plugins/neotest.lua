return {
  "nvim-neotest/neotest",
  enabled = true,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "V13Axel/neotest-pest",
    "olimorris/neotest-phpunit",
  },
  config = function()
    require("neotest").setup({
      log_level = vim.log.levels.DEBUG,
      dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
      adapters = {
        require("neotest-pest")({}),
        require("neotest-phpunit"),
      },
    })
  end,
  keys = {
    {
      "<leader>t",
      "",
      desc = "Tests",
    },
    {
      "<leader>tn",
      function()
        require("neotest").run.run()
      end,
      desc = "Run the nearest test",
    },
    {
      "<leader>ta",
      function()
        require("neotest").run.run(vim.fn.getcwd() .. "/tests")
      end,
      desc = "Run all tests (tests fail)",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run the current file",
    },
    {
      "<leader>ts",
      "<cmd>Neotest summary open<cr>",
      desc = "Displays test suite structure",
    },
    {
      "<leader>to",
      "<cmd>Neotest output-panel toggle<cr>",
      desc = "Toggle output panel",
    },
  },
}
