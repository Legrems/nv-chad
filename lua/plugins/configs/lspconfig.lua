dofile(vim.g.base46_cache .. "lsp")
require "nvchad.lsp"

local M = {}
local utils = require "core.utils"

-- export on_attach & capabilities for custom lspconfigs
M.on_attach = function(client, bufnr)
  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end
end

-- disable semantic tokens
M.on_init = function(client, _)
  if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }

-- LSP settings (for overriding per client)
M.handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

require("lspconfig").lua_ls.setup {
  on_init = M.on_init,
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  handlers = M.handlers,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }

require("lspconfig").pyright.setup {
  on_init = M.on_init,
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  handlers = M.handlers,

  settings = {
    pyright = {
      -- Options available here: https://github.com/microsoft/pyright/blob/main/docs/settings.md
      disableOrganizeImports = true, -- Using Ruff
      -- disableLanguageServices = true, -- Using Ruff
    },
    python = {
      analysis = {
        -- ignore = { "*" }, -- Using Ruff
        -- typeCheckingMode = "off", -- Using mypy
        diagnosticSeverityOverrides = {
          reportMissingImports = false,
          reportAttributeAccessIssue = false,
        },
      },
    },
  },
}

-- -- This can be used for removing message based on regex etc. For now, all those message are disabled by the tagSupport.valueSet
-- local function filter(arr, func)
--   -- Filter in place
--   -- https://stackoverflow.com/questions/49709998/how-to-filter-a-lua-array-inplace
--   local new_index = 1
--   local size_orig = #arr
--   for old_index, v in ipairs(arr) do
--     if func(v, old_index) then
--       arr[new_index] = v
--       new_index = new_index + 1
--     end
--   end
--   for i = new_index, size_orig do
--     arr[i] = nil
--   end
-- end
--
-- local function filter_diagnostics(diagnostic)
--   -- Only filter out Pyright stuff for now
--   if diagnostic.source ~= "Pyright" then
--     return true
--   end
--
--   -- Allow kwargs to be unused, sometimes you want many functions to take the
--   -- same arguments but you don't use all the arguments in all the functions,
--   -- so kwargs is used to suck up all the extras
--   if diagnostic.message == '"kwargs" is not accessed' then
--     return false
--   end
--
--   -- Allow variables starting with an underscore
--   if string.match(diagnostic.message, '"_.+" is not accessed') then
--     return false
--   end
--
--   -- For now, remove all not accessed message. I will still have assigned but not accessed message!
--   if string.match(diagnostic.message, '".+" is not accessed') then
--     return false
--   end
--
--   return true
-- end
--
-- local function custom_on_publish_diagnostics(a, params, client_id, c)
--   filter(params.diagnostics, filter_diagnostics)
--   vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_id, c)
-- end
--
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(custom_on_publish_diagnostics, {})

return M
