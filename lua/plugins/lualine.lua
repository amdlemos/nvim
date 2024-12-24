if true then
  return {}
end
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  extensions = { "quickfix", "nvim-tree" },
  config = function()
    require("lualine").setup({

      options = { theme = "astrotheme" },
    })
  end,
}
