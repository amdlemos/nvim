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
      require("astrotheme").setup({
        style = {
          inactive = false,
        }
      })
    end,
  },
}
