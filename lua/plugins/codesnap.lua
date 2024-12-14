return {
  "mistricky/codesnap.nvim",
  enabled = false,
  build = "make build_generator",
  keys = {
    { "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
    { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/NvimPictures" },
  },
  opts = {
    save_path = "~/NvimPictures",
    has_breadcrumbs = true,
    bg_theme = "bamboo",
  },
}
