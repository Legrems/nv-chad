-- Implement delta as previewer for diffs

local previewers = require('telescope.previewers')
local builtin = require('telescope.builtin')
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

return E
