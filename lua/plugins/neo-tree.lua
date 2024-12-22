return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "rebelot/heirline.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      -- Configuração do Neo-tree (mantida igual)
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

      require("neo-tree").setup({
        -- ... (mesma configuração anterior do Neo-tree)
      })

      -- Configuração atualizada do Heirline com bufferline
      local conditions = require("heirline.conditions")
      local utils = require("heirline.utils")

      -- Cores para a statusline e bufferline
      local colors = {
        bright_bg = utils.get_highlight("Folded").bg,
        bright_fg = utils.get_highlight("Folded").fg,
        red = utils.get_highlight("DiagnosticError").fg,
        dark_red = utils.get_highlight("DiffDelete").bg,
        green = utils.get_highlight("String").fg,
        blue = utils.get_highlight("Function").fg,
        gray = utils.get_highlight("NonText").fg,
        orange = utils.get_highlight("Constant").fg,
        purple = utils.get_highlight("Statement").fg,
        cyan = utils.get_highlight("Special").fg,
        diag_warn = utils.get_highlight("DiagnosticWarn").fg,
        diag_error = utils.get_highlight("DiagnosticError").fg,
        diag_hint = utils.get_highlight("DiagnosticHint").fg,
        diag_info = utils.get_highlight("DiagnosticInfo").fg,
        git_del = utils.get_highlight("diffDeleted").fg,
        git_add = utils.get_highlight("diffAdded").fg,
        git_change = utils.get_highlight("diffChanged").fg,
      }

      -- Componente de Buffer individual
      local BufferComponent = {
        init = function(self)
          self.filename =
            vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.bufnr), ":t")
          self.modified = vim.api.nvim_buf_get_option(self.bufnr, "modified")
          self.active = vim.api.nvim_get_current_buf() == self.bufnr
        end,
        provider = function(self)
          local filename = self.filename
          if filename == "" then
            filename = "[No Name]"
          end
          local modified = self.modified and " ●" or ""
          return string.format(" %s%s ", filename, modified)
        end,
        hl = function(self)
          if self.active then
            return { fg = colors.bright_fg, bg = colors.blue, bold = true }
          else
            return { fg = colors.gray, bg = colors.bright_bg }
          end
        end,
      }

      -- Componente da Bufferline completa
      local Bufferline = {
        init = function(self)
          self.buffers = vim.tbl_filter(function(bufnr)
            return vim.api.nvim_buf_is_valid(bufnr)
              and vim.api.nvim_buf_get_option(bufnr, "buflisted")
          end, vim.api.nvim_list_bufs())
        end,
        static = {
          draw_separator = function(self)
            return "│"
          end,
        },
        {
          provider = function()
            return " "
          end,
          hl = { bg = colors.bright_bg },
        },
        {
          condition = function(self)
            return #self.buffers > 0
          end,
          utils.make_buflist(BufferComponent, {
            provider = function(self)
              return self:draw_separator()
            end,
          }, {
            provider = function()
              return " "
            end,
          }),
        },
      }

      -- Componentes da statusline (mantidos da configuração anterior)
      local ViMode = {
        -- ... (mesma configuração do ViMode)
      }

      local FileNameBlock = {
        -- ... (mesma configuração do FileNameBlock)
      }

      local FileIcon = {
        -- ... (mesma configuração do FileIcon)
      }

      local FileName = {
        -- ... (mesma configuração do FileName)
      }

      local FileFlags = {
        -- ... (mesma configuração do FileFlags)
      }

      -- Configuração final do Heirline com Winbar (bufferline) e Statusline
      require("heirline").setup({
        winbar = Bufferline,
        statusline = {
          ViMode,
          FileNameBlock,
          FileIcon,
          FileName,
          FileFlags,
        },
      })

      -- Atalhos para navegação entre buffers
      vim.api.nvim_set_keymap(
        "n",
        "]b",
        ":bnext<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "[b",
        ":bprevious<CR>",
        { noremap = true, silent = true }
      )

      -- Atalhos para o Neo-tree
      vim.api.nvim_set_keymap(
        "n",
        "<leader>e",
        ":Neotree filesystem reveal left<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>b",
        ":Neotree buffers reveal float<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>g",
        ":Neotree git_status reveal float<CR>",
        { noremap = true, silent = true }
      )
    end,
  },
}
