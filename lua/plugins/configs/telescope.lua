local custom_actions = {}
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local from_entry = require("telescope.from_entry")


local entry_to_qf = function(entry)
  local text = entry.text

  if not text then
    if type(entry.value) == "table" then
      text = entry.value.text
    else
      text = entry.value
    end
  end

  return {
    bufnr = entry.bufnr,
    filename = from_entry.path(entry, false, false),
    lnum = vim.F.if_nil(entry.lnum, 1),
    col = vim.F.if_nil(entry.col, 1),
    text = text,
  }
end

local send_selected_to_list_without_closing_prompt = function(prompt_bufnr, mode, target)
  local picker = action_state.get_current_picker(prompt_bufnr)

  local qf_entries = {}
  for _, entry in ipairs(picker:get_multi_selection()) do
    table.insert(qf_entries, entry_to_qf(entry))
  end

  local prompt = picker:_get_prompt()
  -- actions.close(prompt_bufnr)

  vim.api.nvim_exec_autocmds("QuickFixCmdPre", {})
  if target == "loclist" then
    vim.fn.setloclist(picker.original_win_id, qf_entries, mode)
  else
    local qf_title = string.format([[%s (%s)]], picker.prompt_title, prompt)
    vim.fn.setqflist(qf_entries, mode)
    vim.fn.setqflist({}, "a", { title = qf_title })
  end
  vim.api.nvim_exec_autocmds("QuickFixCmdPost", {})
end

function custom_actions._multiopen(prompt_bufnr, cmd, cmd2, mode, list)
  -- actions.send_selected_to_loclist(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  local single = picker:get_selection()

  local str = ""

  if #multi > 0 then

    send_selected_to_list_without_closing_prompt(prompt_bufnr, mode, list)

    for i, j in ipairs(multi) do
      if i % 2 == 1 then
        str = str..cmd.." "..j[1].." | "
      else
        str = str..cmd2.." "..j[1].." | "
      end
    end

  else
    str = cmd.." "..single[1]
  end

  -- To avoid populating qf or doing ":edit! file", close the prompt first
  actions.close(prompt_bufnr)
  vim.api.nvim_command(str)
end

function custom_actions.multi_selection_open(prompt_bufnr)
  return custom_actions._multiopen(prompt_bufnr, "edit", "edit", "a", "loclist")
end

function custom_actions.multi_selection_vsplit(prompt_bufnr)
  return custom_actions._multiopen(prompt_bufnr, "vsplit", "split", "a", "loclist")
end

function custom_actions.multi_selection_split(prompt_bufnr)
  return custom_actions._multiopen(prompt_bufnr, "split", "vsplit", "a", "loclist")
end

function custom_actions.multi_selection_vtab(prompt_bufnr)
  return custom_actions._multiopen(prompt_bufnr, "tabe", "tabe", "a", "loclist")
end

local options = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.60,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.90,
      height = 0.92,
      preview_cutoff = 200,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      n = { ["q"] = actions.close },
    },
  },
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      mappings = {
        n = {
          ["d"] = "delete_buffer",
        },
        i = {
          ["<C-d>"] = "delete_buffer",
        }
      }
    },
    find_files = {
      mappings = {
        i = {
          ["<CR>"] = custom_actions.multi_selection_open,
          ["<C-V>"] = custom_actions.multi_selection_vsplit,
          ["<C-X>"] = custom_actions.multi_selection_split,
          ["<C-T>"] = custom_actions.multi_selection_tab,
          ["<C-SPACE>"] = actions.send_selected_to_qflist,
        },
        n = i,
      }
    }
  },

  extensions_list = { "themes", "terms", "fzf" },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

return options
