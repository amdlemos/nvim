-- local lsp = require("vim.lsp")
-- local util = require("plugins.lspconfig.util")
local lspconfig = require("lspconfig")
local intelephense_capabilities =
  require("plugins.lspconfig.intelephense_capabilities")
local settings = require("plugins.lspconfig.intelephense_settings")

local on_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
end

lspconfig.intelephense.setup({
  capabilities = intelephense_capabilities,
  an_attach = on_attach,
  init_options = {
    clearCache = true,
  },
  settings = settings,
})
