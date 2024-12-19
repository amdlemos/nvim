-- if true then
--   return {}
-- end
return {
  "mfussenegger/nvim-dap",
  config = function()
    require("dap-vscode-js").setup({
      node_path = "node",
      -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
      debugger_cmd = { "node", "/home/amdlemos/.config/vscode-js-debug/js-debug/src/dapDebugServer.js" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
      adapters = {
        "chrome",
        "pwa-node",
        "pwa-chrome",
        "pwa-msedge",
        "node-terminal",
        "pwa-extensionHost",
        "node",
        "chrome",
      }, -- which adapters to register in nvim-dap
      -- debugger_port = 9229, -- Altere para outra porta disponível
      -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
      -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
      -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
    })
    local dap = require("dap")
    local js_based_languages =
      { "typescript", "javascript", "typescriptreact", "javascriptreact" }

    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          localRoot = "${workspaceFolder}", -- Caminho local no host
          cwd = "${workspaceFolder}",
          port = 9229,
          protocol = "inspector",
          remoteRoot = "/var/www/html", -- Caminho remoto dentro do contêiner
          -- websocketAddress = function()
          --   return string.match(
          --     vim.api.nvim_exec(
          --       '!docker logs [conatiner-name]|& grep -oE "ws.*" | tail -1',
          --       true
          --     ),
          --     "ws:.*"
          --   )
          -- end,
        },
      }
    end

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
    --   require("dap").configurations[language] = {
    --     {
    --       type = "pwa-node",
    --       request = "launch",
    --       name = "Launch file",
    --       program = "${file}",
    --       mode = "remote",
    --       port = 5174,
    --       cwd = "${workspaceFolder}",
    --     },
    --     {
    --       type = "pwa-node",
    --       request = "attach",
    --       name = "Attach",
    --       processId = require("dap.utils").pick_process,
    --       cwd = "${workspaceFolder}",
    --     },
    --     {
    --       type = "pwa-chrome",
    --       request = "launch",
    --       name = 'Start Chrome with "localhost"',
    --       url = "http://localhost:3000",
    --       webRoot = "${workspaceFolder}",
    --       userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
    --     },
    --   }
    -- end
  end,
  keys = {
    {
      "<leader>d",
      "",
      desc = "Debug",
    },
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle breakpoint",
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "Continue",
    },
    {
      "<leader>do",
      function()
        require("dap").step_over()
      end,
      desc = "Over",
    },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "Into",
    },
    {
      "<leader>dk",
      function()
        require("dap.ui.widgets").hover()
      end,
      desc = "Open value of expressio",
    },
    {
      "<leader>ds",
      function()
        local widgets = require("dap.ui.widgets")
        local my_sidebar = widgets.sidebar(widgets.scopes)
        my_sidebar.open()
      end,
      desc = "View the current scopes in a sidebar",
    },
    {
      "<leader>df",
      function()
        local widgets = require("dap.ui.widgets")
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
  },
}
