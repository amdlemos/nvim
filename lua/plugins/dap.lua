return {
  "mfussenegger/nvim-dap",
  enabled = true,
  config = function()
    local dap = require("dap")
    -- PHP
    dap.adapters.php = {
      type = "executable",
      command = "node",
      args = { "/home/amdlemos/.config/vscode-php-debug/out/phpDebug.js" },
    }
    dap.configurations.php = {
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
      {
        name = "Listen for Xdebug",
        type = "php",
        request = "launch",
        port = 9003,
      },
    }

    -- JavaScript
    local JS_DEBUG_PATH =
      "/home/amdlemos/.config/js-debug/src/dapDebugServer.js"

    local FIREFOX_DEBUG_PATH =
      "/home/amdlemos/.config/vscode-firefox-debug/dist/adapter.bundle.js"

    -- Configuração do adaptador Chrome
    dap.adapters["pwa-chrome"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = {
          JS_DEBUG_PATH,
          "${port}",
        },
      },
    }
    -- dap.adapters["firefox"] = {
    --   type = "executable",
    --   command = "node",
    --   args = {
    --     FIREFOX_DEBUG_PATH,
    --   },
    -- }

    -- -- Configuração do adaptador Node
    -- dap.adapters["pwa-node"] = {
    --   type = "server",
    --   host = "localhost",
    --   port = "${port}",
    --   executable = {
    --     command = "node",
    --     args = {
    --       JS_DEBUG_PATH,
    --       "${port}",
    --     },
    --   },
    -- }

    -- Configurações para ReactJS
    dap.configurations.javascript = {
      -- Debug React com Chrome
      {
        type = "pwa-chrome",
        name = "Debug React (Chrome)",
        request = "launch",
        url = "http://localhost", -- URL do seu app React
        webRoot = "${workspaceFolder}",
        sourceMaps = true,
        protocol = "inspector",
        port = 9222, -- Porta do Chrome Debug
        skipFiles = { "<node_internals>/**", "**/node_modules/**" },
      },
      -- {
      --   name = "Debug with Firefox",
      --   type = "firefox",
      --   request = "launch",
      --   reAttach = true,
      --   url = "http://localhost",
      --   webRoot = "${workspaceFolder}",
      --   firefoxExecutable = "/usr/bin/firefox",
      --   args = "-start-debugger-server",
      -- },
      -- {
      --   name = "Attach Firefox",
      --   type = "firefox",
      --   request = "attach",
      --   reAttach = true,
      --   host = "127.0.0.1",
      --   ur = "http://localhost",
      --   webRoo = "${workspaceFolder}",
      -- },
      -- -- Attach ao Chrome (para debug de app já em execução)
      -- {
      --   type = "pwa-chrome",
      --   name = "Attach to Chrome",
      --   request = "attach",
      --   port = 9222,
      --   webRoot = "${workspaceFolder}",
      --   sourceMaps = true,
      --   protocol = "inspector",
      --   skipFiles = { "<node_internals>/**", "**/node_modules/**" },
      -- },
      -- -- Debug de Node.js
      -- {
      --   type = "pwa-node",
      --   request = "launch",
      --   name = "Launch Node.js",
      --   program = "${file}",
      --   cwd = "${workspaceFolder}",
      --   sourceMaps = true,
      --   protocol = "inspector",
      --   console = "integratedTerminal",
      --   skipFiles = { "<node_internals>/**", "**/node_modules/**" },
      -- },
      -- -- Debug de Node.js com npm script
      -- {
      --   type = "pwa-node",
      --   request = "launch",
      --   name = "Launch npm script",
      --   runtimeExecutable = "npm",
      --   runtimeArgs = {
      --     "run-script",
      --     "${command:PickProcess}", -- Permite escolher o script do package.json
      --   },
      --   rootPath = "${workspaceFolder}",
      --   cwd = "${workspaceFolder}",
      --   console = "integratedTerminal",
      --   sourceMaps = true,
      --   protocol = "inspector",
      --   skipFiles = { "<node_internals>/**", "**/node_modules/**" },
      -- },
      -- -- Attach ao processo Node.js
      -- {
      --   type = "pwa-node",
      --   request = "attach",
      --   name = "Attach to Node Process",
      --   processId = require("dap.utils").pick_process,
      --   cwd = "${workspaceFolder}",
      --   sourceMaps = true,
      --   skipFiles = { "<node_internals>/**", "**/node_modules/**" },
      -- },
    }

    -- Copia as configurações para javascript e javascriptreact
    dap.configurations.javascriptreact = dap.configurations.javascript
    dap.configurations.typescriptreact = dap.configurations.javascript
    dap.configurations.typescript = dap.configurations.javascript
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
    -- {
    --   "<leader>do",
    --   function()
    --     require("dapui").open()
    --   end,
    --   desc = "Open DAP UI",
    -- },
  },
}
