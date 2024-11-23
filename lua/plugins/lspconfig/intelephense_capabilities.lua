local lsp = require("vim.lsp")
local intelephense_capabilities = {
  textDocumentSync = lsp.protocol.TextDocumentSyncKind.Incremental,
  documentSymbolProvider = true,
  workspaceSymbolProvider = true,
  completionProvider = {
    triggerCharacters = {
      "$",
      ">",
      ":",
      "\\",
      "/",
      "*", -- PHPDoc
      ".",
      "<", -- HTML/JS
    },
    resolveProvider = true,
  },
  signatureHelpProvider = {
    triggerCharacters = { "(", "," },
  },
  definitionProvider = true,
  referencesProvider = true,
  hoverProvider = true,
  documentFormattingProvider = false, -- Dynamic registration if available
  documentRangeFormattingProvider = false, -- Dynamic registration if available
  documentHighlightProvider = true,
  workspace = {
    workspaceFolders = {
      supported = true,
      changeNotifications = true,
    },
  },
  foldingRangeProvider = true, -- With license key only
  implementationProvider = true, -- With license key only
  declarationProvider = true, -- With license key only
  renameProvider = { -- With license key only
    prepareProvider = true,
  },
  typeDefinitionProvider = true, -- With license key only
  selectionRangeProvider = true, -- With license key only
}

return intelephense_capabilities
