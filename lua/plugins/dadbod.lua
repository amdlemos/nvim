-- if true then
--   return {}
-- end
return {
  "tpope/vim-dadbod",
  dependencies = {
    "kristijanhusak/vim-dadbod-ui",
    "kristijanhusak/vim-dadbod-completion",
  },
  opts = {
    db_competion = function()
      ---@diagnostic disable-next-line
      require("cmp").setup.buffer({
        sources = { { name = "vim-dadbod-completion" } },
      })
    end,
  },
  config = function(_, opts)
    vim.g.db_ui_save_location = vim.fn.stdpath("config")
      .. require("plenary.path").path.sep
      .. "db_ui"
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "sql",
      },
      command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
    })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "sql",
        "mysql",
        "plsql",
      },
      callback = function()
        vim.schedule(opts.db_completion)
      end,
    })
    vim.api.nvim_set_keymap(
      "n",
      "<leader>dq",
      "<cmd>DB<CR>",
      { noremap = true, silent = true }
    )
  end,
  init = function()
    require("utils.remaps").map_virtual({
      {
        "<leader>D",
        group = "database",
        icon = { icon = " ", hl = "Constant" },
      },
      {
        "<leader>Dt",
        group = "toggle dadbod",
        icon = { icon = " ", hl = "Constant" },
      },
      {
        "<leader>Df",
        group = "find buffer",
        icon = { icon = " ", hl = "Constant" },
      },
      {
        "<leader>Dr",
        group = "rename buffer",
        icon = { icon = "󰑕 ", hl = "Constant" },
      },
      {
        "<leader>Dq",
        group = "last query",
        icon = { icon = " ", hl = "Constant" },
      },
    })
  end,
  keys = {
    { "<leader>D", "", desc = "Dadbod" },
    -- { "<leader>Dt", "<cmd>DBUIToggle<cr>", desc = "Toggle UI" },
    -- {
    --   "<leader>Dt",
    --   "<cmd>tabnew | DBUIToggle<CR>",
    --   desc = "Toggle UI in a new tab",
    -- },
    {
      "<leader>Dt",
      function()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local buf_name = vim.api.nvim_buf_get_name(buf)
          if buf_name:match("dbui$") then
            -- Encontrou o DBUI, vai para a tab que contém essa janela
            local win_tab = vim.fn.win_id2tabwin(win)[1]
            vim.cmd(win_tab .. "tabnext")
            return
          end
        end

        -- Se não encontrou nenhuma instância do DBUI, cria uma nova tab
        vim.cmd("tabnew | DBUIToggle")
      end,
      desc = "Toggle DBUI in a tab (focus existing or create new)",
    },
    { "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "Find Buffer" },
    { "<leader>Dr", "<cmd>DBUIRenameBuffer<cr>", desc = "Rename Buffer" },
    { "<leader>Dq", "<cmd>DBUILastQueryInfo<cr>", desc = "Last Query " },
  },
}
