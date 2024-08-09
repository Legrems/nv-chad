local custom_actions = {}
local actions = require("telescope.actions")
local lga_actions = require("telescope-live-grep-args.actions")
local action_state = require("telescope.actions.state")
local from_entry = require("telescope.from_entry")
local scan = require("plenary.scandir")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local action_set = require 'telescope.actions.set'
local conf = require('telescope.config').values
local builtin = require("telescope.builtin")

-- Usefull:
-- [[
-- https://github.com/JoosepAlviste/dotfiles/blob/master/config/nvim/lua/j/telescope_custom_pickers.lua
-- ]]


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

function custom_actions.set_extension(prompt_bufnr)
  local current_input = action_state.get_current_line()

  vim.ui.input({ prompt = 'Search in extension: *.' }, function(input)
    if input == nil then
      return
    end

    -- Close and reopen a prompt with the same input
    actions.close(prompt_bufnr)
    builtin.live_grep({ default_text = current_input, type_filter = input })
  end)
end

function custom_actions.to_live_grep_args(prompt_bufnr)
  local current_input = action_state.get_current_line()

  -- Close and reopen a prompt with live_grep_args
  actions.close(prompt_bufnr)
  require("telescope").extensions.live_grep_args.live_grep_args({ default_text = current_input })
end

function custom_actions.set_folders(prompt_bufnr)
  local current_input = action_state.get_current_line()

  local data = {}
  scan.scan_dir(vim.loop.cwd(), {
    hidden = true,
    only_dirs = true,
    respect_gitignore = true,
    on_insert = function(entry)
      table.insert(data, entry .. "/")
    end,
  })
  table.insert(data, 1, "./")

  actions.close(prompt_bufnr)
  -- Create a new picker with Telescope to select folders we want to filter in
  pickers.new({
    prompt_title = 'Select folders for current ("' .. current_input .. '") search',
    finder = finders.new_table { results = data, entry_maker = make_entry.gen_from_file {} },
    previewer = conf.file_previewer {},
    sorter = conf.file_sorter {},
    attach_mappings = function(prompt_bufnr2)
      action_set.select:replace(function()
        local current_picker = action_state.get_current_picker(prompt_bufnr2)

        local dirs = {}
        local selections = current_picker:get_multi_selection()
        if vim.tbl_isempty(selections) then
          table.insert(dirs, action_state.get_selected_entry().value)
        else
          for _, selection in ipairs(selections) do
            table.insert(dirs, selection.value)
          end
        end

        actions.close(prompt_bufnr2)
        builtin.live_grep({ default_text = current_input, search_dirs = dirs })
      end)
      return true

    end,
  }):find()

end

function custom_actions.set_files(prompt_bufnr)
  local current_input = action_state.get_current_line()
  local find_command = {"rg", "--files", "--color=never", "--no-heading"}
  actions.close(prompt_bufnr)
  if current_input ~= "" then
    find_command = {"rg", "--color=never", "--no-heading", "-l", current_input}
  end

  local opts = {
    entry_maker = make_entry.gen_from_file(),
    find_command = find_command,
  }

  print(vim.inspect(find_command))
  -- Create a new picker with Telescope to select files we want to filter in
  pickers
    .new(opts, {
      prompt_title = 'Select files for current ("' .. current_input .. '") search',
      __locations_input = true,
      finder = finders.new_oneshot_job(find_command, opts),
      previewer = conf.grep_previewer(opts),
      sorter = conf.file_sorter(opts),
      attach_mappings = function(prompt_bufnr2)
        actions.select_default:replace(function()
          local current_picker = action_state.get_current_picker(prompt_bufnr2)

          local files = {}
          local selections = current_picker:get_multi_selection()
          if vim.tbl_isempty(selections) then
            local entry = action_state.get_selected_entry()
            table.insert(files, entry.value)
          else
            for _, selection in ipairs(selections) do
              table.insert(files, selection.value)
            end

          end

          -- Close the preview picker and select a new one, restricted to the files selected
          actions.close(prompt_bufnr2)
          builtin.live_grep({ default_text = current_input, search_dirs = files })
        end)
        return true
      end,
    })
    :find()

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
          -- Fuzzy refine ("Freeze the current list and start a fuzzy search in the frozen list")
          ["<C-i>"] = actions.to_fuzzy_refine,

          -- Send to qflist or loclist
          ["<C-l>"] = actions.smart_send_to_loclist,
          ["<C-Space>"] = actions.smart_send_to_qflist,

          -- Multi selection open
          ["<CR>"] = custom_actions.multi_selection_open,
          ["<C-v>"] = custom_actions.multi_selection_vsplit,
          ["<C-X>"] = custom_actions.multi_selection_split,
          ["<C-T>"] = custom_actions.multi_selection_tab,
        },
        n = i,
      }
    },
    live_grep = {
      mappings = {
        i = {
          -- Fuzzy refine ("Freeze the current list and start a fuzzy search in the frozen list")
          ["<C-i>"] = actions.to_fuzzy_refine,

          -- Send to qflist or loclist
          ["<C-l>"] = actions.smart_send_to_loclist,
          ["<C-Space>"] = actions.smart_send_to_qflist,

          -- To quote prompt -> Pass to live_grep_args
          ["<C-k>"] = custom_actions.to_live_grep_args,

          -- Search for files/folder/extensions
          ["<C-f>"] = custom_actions.set_files,
          ["<C-g>"] = custom_actions.set_folders,
          ["<C-e>"] = custom_actions.set_extension,
        },
        n = i,
      }
    }
  },

  extensions_list = { "themes", "terms", "fzf", "macrothis", "live_grep_args" },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i = {
          -- Fuzzy refine ("Freeze the current list and start a fuzzy search in the frozen list")
          ["<C-i>"] = actions.to_fuzzy_refine,

          -- Send to qflist or loclist
          ["<C-l>"] = actions.smart_send_to_loclist,
          ["<C-Space>"] = actions.smart_send_to_qflist,

          -- Quote prompt, for passing parameters to vimgrep
          ["<C-k>"] = lga_actions.quote_prompt(),
        },
      }
    }
  }
}

return options
