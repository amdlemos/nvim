if true then
  return {}
end
return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")
    dap.adapters.php = {
      type = "executable",
      command = "node",
      args = { "/home/amdlemos/.config/vscode-php-debug/out/phpDebug.js" },
    }
    dap.configurations.php = {
      -- to listen to php call in docker container
      {
        name = "Listen for Xdebug Docker",
        type = "php",
        request = "launch",
        port = 9003,
        -- this is where your file is in the container
        pathMappings = {
          -- ["/var/www/html"] = "/home/amdlemos/backup/autis/revista-exato/admin/src",
          ["/var/www/html"] = "/home/amdlemos/github/whitelabel",
        },
      },
    }
  end,
  keys = {
    {
      "<leader>dk",
      function()
        require('dap.ui.widgets').hover()
      end,
      desc = "Open value of expressio",
    },
    {
      "<leader>ds",
      function()
        local widgets = require('dap.ui.widgets')
        local my_sidebar = widgets.sidebar(widgets.scopes)
        my_sidebar.open()
      end,
      desc = "View the current scopes in a sidebar",
    },
    {
      "<leader>df",
      function()
        local widgets = require('dap.ui.widgets')
        local my_sidebar = widgets.sidebar(widgets.frames)
        local winopts = { width = 150 }
        my_sidebar.open(winopts)
      end,
      desc = "View the current frames in a sidebar",
    },
    {
      "<leader>do",
      function()
        require("dapui").open()
      end,
      desc = "Open DAP UI",
    },
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
  }
}
