-- Implement delta as previewer for diffs

local previewers = require('telescope.previewers')
local builtin = require('telescope.builtin')
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values

local E = {}

local delta = previewers.new_termopen_previewer {
  get_command = function(entry)
    -- this is for status
    -- You can get the AM things in entry.status. So we are displaying file if entry.status == '??' or 'A '
    -- just do an if and return a different command
    if entry.status == '??' or 'A ' then
      return { 'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value }
    end

    -- note we can't use pipes
    -- this command is for git_commits and git_bcommits
    return { 'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value .. '^!' }

  end
}

E.my_git_commits = function(opts)
  opts = opts or {}
  opts.previewer = delta

  builtin.git_commits(opts)
end

E.my_git_bcommits = function(opts)
  opts = opts or {}
  opts.previewer = delta

  builtin.git_bcommits(opts)
end

E.my_git_status = function(opts)
  opts = opts or {}
  opts.previewer = delta

  builtin.git_status(opts)
end

E.my_git_branches = function(opts)
  opts = opts or {}
  opts.previewer = delta

  builtin.git_branches(opts)
end

E.project_files = function()
  local opts = {} -- define here if you want to define something
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    require"telescope.builtin".git_files(opts)
  else
    require"telescope.builtin".find_files(opts)
  end
end

local custom_commands = require("custom.commands")

E.cpickers = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Commands",

    finder = finders.new_table {
      results = custom_commands,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry[1],
          ordinal = entry[2],
        }
      end
    },

    previewer = previewers.new_buffer_previewer {
      title = "Custom commands preview",
      define_preview = function (self, entry, _)
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {
          entry['ordinal'],
        })
      end
    },

    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.cmd(selection.ordinal)
      end)
      return true
    end,

    sorter = conf.generic_sorter(opts),
  }):find()
end

return E
