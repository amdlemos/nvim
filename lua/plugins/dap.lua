-- if true then
--   return {}
-- end
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
    -- Caminho para o debugger
    local JS_DEBUG_PATH =
      "/home/amdlemos/.config/js-debug/src/dapDebugServer.js"
    -- Função de log para debug
    local function log_debug(message)
      vim.notify("DAP Debug: " .. message, vim.log.levels.DEBUG)
    end

    -- Configuração do adaptador Chrome/React
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

    -- Configuração do adaptador Node
    dap.adapters["pwa-node"] = {
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

    -- Configuração do adaptador Firefox
    -- dap.adapters["firefox"] = {
    --   type = "executable",
    --   command = "node",
    --   args = {
    --     JS_DEBUG_PATH,
    --     "${port}",
    --   },
    -- }
    -- Configuração do adaptador Firefox com mais logs
    dap.adapters["firefox"] = {
      type = "executable",
      command = "node",
      args = { JS_DEBUG_PATH },
      options = {
        env = {
          VSCODE_DEBUG_PORT = "${port}",
          VSCODE_DEBUG_LOG = "1", -- Habilita logging
          NODE_DEBUG = "debug", -- Debug detalhado do Node
        },
      },
      enrich_config = function(config, on_config)
        log_debug("Firefox config: " .. vim.inspect(config))
        on_config(config)
      end,
    }

    -- Configurações para ReactJS
    dap.configurations.javascriptreact = {
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
      {
        type = "pwa-chrome",
        name = "Attach to Chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
      },
      {
        type = "firefox",
        name = "Debug React (Firefox)",
        request = "launch",
        url = "http://localhost",
        webRoot = "${workspaceFolder}",
        firefoxExecutable = "/usr/bin/firefox", -- Ajuste para o caminho do seu Firefox
        skipFiles = { "<node_internals>/**", "**/node_modules/**" },
        pathMappings = {
          {
            url = "webpack:///",
            path = "${workspaceFolder}/",
          },
        },
      },
      {
        type = "firefox",
        name = "Attach to Firefox",
        request = "attach",
        url = "http://localhost",
        webRoot = "${workspaceFolder}",
        pathMappings = {
          {
            url = "webpack:///",
            path = "${workspaceFolder}/",
          },
        },
      },
    }

    -- Configurações para JavaScript/React
    -- dap.configurations.javascript = {
    --   {
    --     type = "pwa-chrome",
    --     name = "Debug React (Chrome)",
    --     request = "launch",
    --     url = "http://localhost",
    --     webRoot = "${workspaceFolder}",
    --     sourceMaps = true,
    --     protocol = "inspector",
    --     port = 9222,
    --     skipFiles = { "<node_internals>/**", "**/node_modules/**" },
    --   },
    --   {
    --     type = "pwa-node",
    --     request = "launch",
    --     name = "Launch Current File (pwa-node)",
    --     cwd = "${workspaceFolder}",
    --     args = { "${file}" },
    --     sourceMaps = true,
    --     protocol = "inspector",
    --   },
    --   {
    --     type = "firefox",
    --     name = "Debug React (Firefox)",
    --     request = "launch",
    --     url = "http://localhost:3000",
    --     webRoot = "${workspaceFolder}",
    --     firefoxExecutable = "/usr/bin/firefox", -- Ajuste para o caminho do seu Firefox
    --     skipFiles = { "<node_internals>/**", "**/node_modules/**" },
    --     pathMappings = {
    --       {
    --         url = "webpack:///",
    --         path = "${workspaceFolder}/",
    --       },
    --     },
    --   },
    -- Configuração para attach no Firefox
    -- {
    --   type = "firefox",
    --   name = "Attach to Firefox",
    --   request = "attach",
    --   url = "http://localhost:3000",
    --   webRoot = "${workspaceFolder}",
    --   pathMappings = {
    --     {
    --       url = "webpack:///",
    --       path = "${workspaceFolder}/",
    --     },
    --   },
    -- },
    -- }

    -- Copia as configurações para javascriptreact (esse tá funcionando no google)
    -- dap.configurations.javascript = dap.configurations.javascript

    -- Copia as configurações para javascript e javascriptreact
    dap.configurations.javascriptreact = dap.configurations.javascriptreact
    -- dap.configurations.javascriptreact = dap.configurations.typescriptreact

    -- Função auxiliar para garantir que não há debuggers ativos
    local function kill_all_dap_sessions()
      for _, session in pairs(dap.sessions()) do
        session:terminate()
      end
      dap.terminate()
    end

    -- Adiciona listeners para eventos DAP para debug
    dap.listeners.after.event_initialized["dap-init"] = function()
      log_debug("Debug session initialized")
    end

    dap.listeners.after.event_terminated["dap-term"] = function()
      log_debug("Debug session terminated")
    end

    dap.listeners.before.event_exited["dap-exit"] = function(session, body)
      log_debug(
        "Debug session exiting with code: " .. (body.exitCode or "unknown")
      )
      log_debug("Exit reason: " .. vim.inspect(body))
    end

    -- Comando para matar todas as sessões DAP
    vim.api.nvim_create_user_command("DapKillAll", kill_all_dap_sessions, {})
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
