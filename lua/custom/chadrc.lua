---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "onedark",
  theme_toggle = { "onedark", "onedark" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = {
    order = {
      "macro",
      "mode",
      "relativepath",
      "file",
      "git",
      "%=",
      "lsp_msg",
      "%=",
      "diagnostics",
      "lsp",
      "cwd",
      "cursor",
    },
    modules = {
      macro = function()
        local noice = require "noice"
        if noice.api.statusline.mode.has() then
          return "%#St_CommandMode#" .. noice.api.statusline.mode.get()
        end
        return ""
      end,
      relativepath = function()
        local stbufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
        local path = vim.api.nvim_buf_get_name(stbufnr)

        if path == "" then
          return ""
        end

        return "%#St_relativepath#  " .. vim.fn.expand "%:.:h" .. " /"
      end,
    },
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
