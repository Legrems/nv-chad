local custom_actions = {}
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

function custom_actions._multiopen(prompt_bufnr, open_cmd)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local selected_entry = action_state.get_selected_entry()
    local num_selections = #picker:get_multi_selection()

    if not num_selections or num_selections < 1 then
        actions.add_selection(prompt_bufnr)
    end

    actions.send_selected_to_loclist(prompt_bufnr)
    vim.cmd("lfdo " .. open_cmd)
end

function custom_actions.multi_selection_open(prompt_bufnr)
    return custom_actions._multiopen(prompt_bufnr, "edit")
end

function custom_actions.multi_selection_vsplit(prompt_bufnr)
    return custom_actions._multiopen(prompt_bufnr, "vsplit")
end

function custom_actions.multi_selection_split(prompt_bufnr)
    return custom_actions._multiopen(prompt_bufnr, "split")
end

function custom_actions.multi_selection_vtab(prompt_bufnr)
    return custom_actions._multiopen(prompt_bufnr, "tabe")
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
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
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
      n = { ["q"] = require("telescope.actions").close },
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
          ["<C-SPACE>"] = actions.send_selected_to_loclist,
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
