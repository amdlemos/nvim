if true then
  return {}
end
return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  config = function()
    require("dapui").setup()
    -- vim.keymap.set("n", "<leader>do", function()
    --   require("dapui").open()
    -- end)
    vim.keymap.set("n", "<leader>dk", function()
      require('dap.ui.widgets').hover()
    end)
  end
}
