-- n, v, i, t = mode names

local M = {}

M.general = {
  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
    ["<C-e>"] = { "<End>", "End of line" },

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },
  },

  n = {
    ["<leader>n"] = { ":noh <CR>", "Clear highlights" },
    ["<leader>rr"] = { ":source $MYVIMRC<CR>", "Reload config file" },
    ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },
    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "Window left" },
    ["<C-l>"] = { "<C-w>l", "Window right" },
    ["<C-j>"] = { "<C-w>j", "Window down" },
    ["<C-k>"] = { "<C-w>k", "Window up" },

    -- ["<C-d>"] = { "<cmd> tab Git diff %<CR>", "Git diff this file" },
    ["<C-d>"] = { "<cmd> DiffviewOpen -- %<CR>", "Git diff this file" },
    ["<C-o>"] = { "<cmd> DiffviewFileHistory %<CR>", "Git history diff this file" },
    ["<C-a-d>"] = { "<cmd> DiffviewClose<CR>", "Close git diff" },
    -- ["<C-p>"] = { "<cmd> tab Git diff<CR>", "Git diff global" },
    ["<C-p>"] = { "<cmd> DiffviewOpen<CR>", "Git diff global" },
    ["<a-p>"] = { ":DiffviewOpen HEAD~", "Show last N commits" },
    ["<leader>gd"] = { "<cmd> DiffviewClose<CR>", "Git diff close" },

    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },

    -- Copy all
    -- ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

    -- Quit
    ["<C-q>"] = { "<cmd> q! <CR>", "Force quit window" },

    -- line numbers
    -- ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
    -- ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },

    -- allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    -- ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    -- ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },

    ["<leader>y"] = {"<cmd> :w! /tmp/vimtmp<CR>", "Save into a global tmp file"},
    ["<leader>p"] = {"<cmd> :r! cat /tmp/vimtmp<CR>", "Restore from the global tmp file"},

    -- new buffer
    -- ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
    -- ["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },
  },

  t = {
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
  },

  v = {
    -- ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["<"] = { "<gv", "Indent line" },
    [">"] = { ">gv", "Indent line" },
  },

  x = {
    -- ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    -- ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
  },
}

M.customstuffs = {

  n = {
    ["<Return>"] = { "o<ESC>", "Insert new line below" },
    ["<BS>"] = { "O<ESC>", "Insert new line above" },
    ["<C-c>"] = { "<cmd> vertical topleft Git <bar> vertical resize 50<CR>", "Show Git status on a left pane" },
    ["<F1>"] = { "<cmd> tabprevious<CR>", "Previous tab" },
    ["<F2>"] = { "<cmd> tabnext<CR>", "Next tab" },
    ["<F3>"] = { "<cmd> Flog -all<CR>", "Show git tree" },
    ["<F4>"] = { "<cmd> tab Git show -", "Git show N last commits" },
    ["<C-t>"] = { "<cmd> TagbarToggle<CR>", "Show tagbar" },
    ["<leader>ra"] = { "<cmd> call VrcQuery()<CR>", "Call REST endpoint" },
    ["<leader>dl"] = { "0d$", "Delete line from start" },
    ["<leader>gpu"] = { "<cmd> Git pull<CR>", "Git pull" },
    ["<leader>gpf"] = { ":Git push ", "Git push with option" },
    ["<leader>gmm"] = { "<cmd> Git merge master<CR>", "Git merge master" },
    ["<leader>gmi"] = { ":Git merge ", "Git merge ..." },
    ["<leader>ga"] = { ":Git commit -a --amend --no-edit --no-verify", "Git commit -a --amend --no-edit --no-verify" },
    ["<leader>gnb"] = { ":Git checkout -b ", "Checkout to a new branch" },
    ["<leader>gri"] = { ":Git rebase -i HEAD~", "Git rebase interactive from HEAD" },
    ["<leader>grm"] = { ":Git rebase -i master", "Git rebase interactive from master" },
    ["<leader>grr"] = { ":Git rebase -i ", "Git rebase interactive from <select>" },

    -- ["<leader>mkd"] = { "<cmd>lua vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})<CR>", "Open markdown preview" },
    -- ["<leader>mkc"] = { "<cmd>lua vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})<CR>", "Open markdown preview" },

    ["n"] = { "nzz", "Next + auto center" },
    ["N"] = { "Nzz", "Previous + auto center" },
    ["("] = { "(zz", "Previous + auto center" },
    [")"] = { ")zz", "Previous + auto center" },
    ["{"] = { "{zz", "Previous + auto center" },
    ["}"] = { "}zz", "Previous + auto center" },
    ["[["] = { "[[zz", "Previous + auto center" },
    ["]]"] = { "]]zz", "Previous + auto center" },

    -- Mappings: TODO

    -- "trim(system('git branch --show-current 2>/dev/null'))"
    -- ["<leader>ct"] = { ":call append(line('.') - 1, repeat(' ', indent('.')) . '# TODO-' . trim(system('git branch --show-current 2>/dev/null')) . ': ' . input('Comment >'))<CR>", "Add TODO comment + add to quickfix list" },
    ["<leader>ct"] = { ":call append(line('.') - 1, repeat(' ', indent('.')) . '# TODO: ' . input('Comment >'))<CR>", "Add TODO comment + add to quickfix list" },

    ["<leader>ww"] = { ":lua require('nvim-window').pick()<CR>", "Pick window to goto" },
    ["<leader>wm"] = { ":WinShift<CR>", "Enter move window mode" },
    ["<leader>ws"] = { ":WinShift swap<CR>", "Swap window, with selection" },

    ["<leader>gg"] = { ":LazyGit<CR>", "Open lazygit" },
  },
  v = {
    ["n"] = { "nzz", "Next + auto center" },
    ["N"] = { "Nzz", "Previous + auto center" },
    ["("] = { "(zz", "Previous + auto center" },
    [")"] = { ")zz", "Previous + auto center" },
    ["{"] = { "{zz", "Previous + auto center" },
    ["}"] = { "}zz", "Previous + auto center" },
    ["[["] = { "[[zz", "Previous + auto center" },
    ["]]"] = { "]]zz", "Previous + auto center" },
  },
}

M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["<tab>"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["<S-tab>"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },

    -- close buffer + hide terminal buffer
    ["<leader>x"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      "Close buffer",
    },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>ci"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["<leader>ci"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.lspconfig = {
  plugin = true,

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["<leader>ra"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "LSP references",
    },

    ["<leader>lf"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
      end,
      "Goto next",
    },

    -- ["<leader>q"] = {
    --   function()
    --     vim.diagnostic.setloclist()
    --   end,
    --   "Diagnostic setloclist",
    -- },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
  },

  v = {
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- Resume
    ["<a-f>"] = { "<cmd> Telescope resume <CR>", "Resume" },
    -- find
    ["<C-g>"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<C-x>"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<C-f>"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<C-b>"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },

    ["<leader>fg"] = { "<cmd> lua require('telescope.builtin').live_grep({default_text=vim.fn.getreg('/')}) <CR>", "Live grep with actual search value as prefix" },
    ["<leader>gf"] = { "<cmd> lua require('telescope.builtin').find_files({default_text=vim.fn.getreg('/')}) <CR>", "Live grep with actual search value as prefix" },
    ["<leader>ac"] = { ":execute 'vimgrep' input('Pattern >', getreg('/')) '**/*' <CR>", "add search term files in quickfix list" },
    -- ["<leader>qr"] = { ":execute 'cdo' '%s/' . input('Search term >', getreg('/')) . '/' . input('Replace by >', getreg('')) . '/g | update' <CR>", "Replace pattern in all quickfix list" },
    ["<leader>qr"] = { ":cdo '%s/' . input('Search term >', getreg('/')) . '/' . input('Replace by >', '') . '/g | update' <CR>", "Replace pattern in all quickfix list" },
    ["<leader>br"] = { ":execute '%s/' . input('Search term >', getreg('/')) . '/' . input('Replace by >', '') . '/g | update' <CR>", "Replace pattern in current buffer" },

    ["<leader>ql"] = { "<cmd> Telescope quickfix <CR>", "Show quickfix list" },
    ["<leader>qn"] = { ":cnext<CR>", "Jump to next in quickfix list" },
    ["<leader>qp"] = { ":cprevious<CR>", "Jump to previous in quickfix list" },

    ["<leader>ll"] = { "<cmd> Telescope loclist <CR>", "Show loclist list" },
    ["<leader>ln"] = { ":lnext<CR>", "Jump to next in loclist" },
    ["<leader>lp"] = { ":lprevious<CR>", "Jump to previous in loclist" },

    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },

    ["<leader>wl"] = { "<cmd> Telescope workspaces <CR>", "Find workspaces" },

    -- git
    --- Commits
    ["<leader>gc"] = { "<cmd> lua require('custom.telescope').my_git_commits()<CR>", "Custom Git commits" },
    --- Status
    ["<leader>gss"] = { "<cmd> lua require('custom.telescope').my_git_status()<CR>", "Custom Git status" },
    --- Stash
    ["<leader>gsh"] = { "<cmd> Telescope git_stash<CR>", "Git stash" },
    --- Branches
    ["<leader>gbb"] = { "<cmd> Telescope git_branches<CR>", "Git branches" },
    ["<leader>gbc"] = { "<cmd> lua require('custom.telescope').my_git_bcommits()<CR>", "Custom Git branchs commits" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

    ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },

    -- History
    ["<leader>ch"] = { "<cmd> Telescope command_history <CR>", "telescope commands history" },
    ["<leader>/"] = { "<cmd> Telescope search_history <CR>", "telescope search history" },

    -- Diaglist: LSP diagnostics in quick/loc list
    ["<leader>dw"] = { "<cmd>lua require('diaglist').open_all_diagnostics()<CR>", "Open all open buffers diagnostics in quickfix list" },
    ["<leader>d0"] = { "<cmd>lua require('diaglist').open_buffer_diagnostics()<CR>", "Open current buffer diagnostics in loclist list" },

    ["<leader>;"] = { "<cmd> Telescope <CR>", "Open Telescope" },
  },
}

M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["<a-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<a-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<a-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<a-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<a-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<a-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },

    -- new
    ["<leader>h"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "New horizontal term",
    },

    ["<leader>v"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "New vertical term",
    },
  },
}

M.whichkey = {
  plugin = true,

  n = {
    ["<leader>wK"] = {
      function()
        vim.cmd "WhichKey"
      end,
      "Which-key all keymaps",
    },
    ["<leader>wk"] = {
      function()
        local input = vim.fn.input "WhichKey: "
        vim.cmd("WhichKey " .. input)
      end,
      "Which-key query lookup",
    },
  },
}

M.blankline = {
  plugin = true,

  n = {
    ["<leader>cc"] = {
      function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd [[normal! _]]
        end
      end,

      "Jump to current context",
    },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    -- Navigation through hunks
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },

    -- actions
    ["<leader>rh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },

    ["<leader>ph"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },

    ["<leader>bb"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },

    ["<leader>td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
  },
}

return M
