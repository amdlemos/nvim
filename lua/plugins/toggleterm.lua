return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = true,
  keys = {
    {
      "<leader>tt",
      function()
        local api = vim.api
        -- Função para verificar se a tab atual contém um toggleterm
        local function is_current_tab_toggleterm()
          local current_tab = api.nvim_get_current_tabpage()
          for _, win in ipairs(api.nvim_tabpage_list_wins(current_tab)) do
            local buf = api.nvim_win_get_buf(win)
            local buf_type = api.nvim_buf_get_option(buf, "filetype")
            if buf_type == "toggleterm" then
              return true
            end
          end
          return false
        end

        -- Função para gerenciar a visibilidade da lualine
        local function manage_lualine()
          if is_current_tab_toggleterm() then
            require("lualine").hide()
          else
            require("lualine").hide({ unhide = true })
          end
        end
        -- Procura por uma janela com o buffer do ToggleTerm em todas as tabs
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local buf_type = vim.api.nvim_buf_get_option(buf, "filetype")
          if buf_type == "toggleterm" then
            -- Encontrou o ToggleTerm, vai para a tab que contém essa janela
            local win_tab = vim.fn.win_id2tabwin(win)[1]
            vim.cmd(win_tab .. "tabnext")
            manage_lualine()
            return
          end
        end
        -- Grupo de autocommands para gerenciar a lualine
        local augroup =
          api.nvim_create_augroup("ToggleTermLualine", { clear = true })

        -- Autocommand para verificar a lualine quando mudar de tab
        api.nvim_create_autocmd("TabEnter", {
          group = augroup,
          callback = function()
            -- Pequeno delay para garantir que o buffer já está carregado
            vim.defer_fn(manage_lualine, 10)
          end,
        })

        -- Autocommand para restaurar a lualine quando sair do Neovim
        api.nvim_create_autocmd("VimLeave", {
          group = augroup,
          callback = function()
            require("lualine").hide({ unhide = true })
          end,
        })

        -- Se não encontrou nenhuma instância do ToggleTerm, cria uma nova tab e abre o terminal
        -- vim.cmd("ToggleTerm direction=tab")
        local cwd = vim.fn.getcwd()
        local session = string.match(cwd, ".*/(.*)")
        local handle = io.popen("zellij list-sessions")
        local result = handle:read("*a")
        handle.close()
        local exist = string.find(result, session) ~= nil
        if exist then
          vim.cmd(
            'TermExec cmd="zellij attach ' .. session .. '"  " direction=tab'
          )
        else
          vim.cmd('TermExec cmd="zellij -s ' .. session .. '"  " direction=tab')
        end
      end,
      desc = "Toggle Terminal in a tab (focus existing or create new)",
    },
  },
}
