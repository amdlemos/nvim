return {
  -- { "ellisonleao/gruvbox.nvim" },
  -- { "rebelot/kanagawa.nvim" },
  -- { "metalelf0/jellybeans-nvim", dependencies = { "rktjmp/lush.nvim" } },
  -- { "projekt0n/github-nvim-theme", name = "github-theme" },
  -- {
  --   "briones-gabriel/darcula-solid.nvim",
  --   dependencies = { "rktjmp/lush.nvim" },
  -- },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "AstroNvim/astrotheme",
    lazy = false,
    config = function()
      local color = require("astrotheme.lib.color")
      require("astrotheme").setup({
        style = {
          inactive = false,
        },
        plugins = {
          ["bufferline.nvim"] = true,
          ["nvim-tree"] = true,
        },
        palettes = {
          astromars = {
            ui = {
              current_line = color.new("#1E1517"):lighten(10):tohex(),
            },
          },
          astrojupiter = {
            ui = {
              current_line = color.new("#F6DDD8"):lighten(50):tohex(),
            },
          },
        },
      })
    end,
  },
}
