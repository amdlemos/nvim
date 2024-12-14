-- if true then
--   return {}
-- end
return {
  { "echasnovski/mini.indentscope", version = "*" },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  { "numToStr/Comment.nvim" },
  config = function()
    require("mini.indentscope").setup({})
    require("ts_context_commentstring").setup({
      enable_autocmd = false,
    })
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end,
}
