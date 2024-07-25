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

    -- ["<leader>y"] = {"<cmd> :w! /tmp/vimtmp<CR>", "Save into a global tmp file"},
    -- ["<leader>p"] = {"<cmd> :r! cat /tmp/vimtmp<CR>", "Restore from the global tmp file"},

    ["<leader>dgg"] = {":lua require('dap').continue() <CR>", "Continue debu[g]ging"},
    ["<leader>dg<CR>"] = {":lua require('dapui').toggle() <CR>", "Toggle DAP ui"},
    ["<leader>dgw"] = {":lua require('dapui').eval() <CR>", "Open floating windows about current [w]ord"},
    ["<leader>dgb"] = {":lua require('dap').toggle_breakpoint() <CR>", "Toggle [b]reakpoint"},
    ["<leader>dgf"] = {":lua require('dap-python').test_method() <CR>", "Debug [f]unction"},
    ["<leader>dgo"] = {":lua require('dap').step_over() <CR>", "DAP step [o]ver method"},
    ["<leader>dgt"] = {":lua require('dap').step_into() <CR>", "DAP step in[t]o method"},
    ["<leader>dgp"] = {":lua require('dap').step_back() <CR>", "DAP step back ([p]revious)"},
    ["<leader>dgs"] = {
      function()
        local widgets = require("dap.ui.widgets")
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open({widgth = '50%'})
      end,
      "DAP Show debugged [s]copes",
    },

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

    ["<leader>dgd"] = {":lua require('dap-python').debug_selection()", "DAP debug selection"},
    ["<leader>dgw"] = {":lua require('dap-python').eval()", "DAP eval selection"},
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
    -- ["<leader>ct"] = { ":call append(line('.') - 1, repeat(' ', indent('.')) . '# TODO-' . trim(system('git branch --show-current 2>/dev/null')) . ': ' . input('Comment >'))<CR>", "Add TODO comment + add to qflist" },
    ["<leader>ct"] = { ":call append(line('.') - 1, repeat(' ', indent('.')) . '# TODO: ' . input('Comment >'))<CR>", "Add TODO comment + add to qflist" },

    ["<leader>ww"] = { ":lua require('nvim-window').pick()<CR>", "Pick window to goto" },
    ["<leader>wm"] = { ":WinShift<CR>", "Enter move window mode" },
    ["<leader>ws"] = { ":WinShift swap<CR>", "Swap window, with selection" },

    ["<leader>gg"] = { ":LazyGit<CR>", "Open lazygit" },

    ["gf"] = { ":call search('[A-Z]', 'W')<CR>", "Go to next uppercase" },
    ["fg"] = { ":call search('[A-Z]', 'bW')<CR>", "Go to last uppercase" },

    ["glb"] = { ":lua require('gitlab').choose_merge_request()<CR>", "Gitlab: Choose merge request" },
    ["glr"] = { ":lua require('gitlab').review()<CR>", "Gitlab: review" },
    ["gls"] = { ":lua require('gitlab').summary()<CR>", "Gitlab: summary" },
    ["glo"] = { ":lua require('gitlab').open_in_browser()<CR>", "Gitlab: open in browser" },
    ["glu"] = { ":lua require('gitlab').copy_mr_url()<CR>", "Gitlab: open in browser" },
    ["glO"] = { ":lua require('gitlab').create_mr()<CR>", "Gitlab: create MR" },
    ["glaa"] = { ":lua require('gitlab').add_assignee()<CR>", "Gitlab: add_assignee" },

-- vim.keymap.set("n", "glb", gitlab.choose_merge_request)
-- vim.keymap.set("n", "glr", gitlab.review)
-- vim.keymap.set("n", "gls", gitlab.summary)
-- vim.keymap.set("n", "glA", gitlab.approve)
-- vim.keymap.set("n", "glR", gitlab.revoke)
-- vim.keymap.set("n", "glc", gitlab.create_comment)
-- vim.keymap.set("v", "glc", gitlab.create_multiline_comment)
-- vim.keymap.set("v", "glC", gitlab.create_comment_suggestion)
-- vim.keymap.set("n", "glO", gitlab.create_mr)
-- vim.keymap.set("n", "glm", gitlab.move_to_discussion_tree_from_diagnostic)
-- vim.keymap.set("n", "gln", gitlab.create_note)
-- vim.keymap.set("n", "gld", gitlab.toggle_discussions)
-- vim.keymap.set("n", "glaa", gitlab.add_assignee)
-- vim.keymap.set("n", "glad", gitlab.delete_assignee)
-- vim.keymap.set("n", "glla", gitlab.add_label)
-- vim.keymap.set("n", "glld", gitlab.delete_label)
-- vim.keymap.set("n", "glra", gitlab.add_reviewer)
-- vim.keymap.set("n", "glrd", gitlab.delete_reviewer)
-- vim.keymap.set("n", "glp", gitlab.pipeline)
-- vim.keymap.set("n", "glM", gitlab.merge)
-- vim.keymap.set("n", "glu", gitlab.copy_mr_url)
-- vim.keymap.set("n", "glP", gitlab.publish_all_drafts)

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

    ["<leader>ff"] = { "<cmd> lua require('telescope.builtin').live_grep({default_text='<<<<<<< HEAD'}) <CR>", "Search for git conflicts" },

    ["<leader>fg<CR>"] = { "<cmd> lua require('telescope.builtin').live_grep({}) <CR>", "Live grep" },
    ["<leader>fg/"] = { "<cmd> lua require('telescope.builtin').live_grep({default_text=vim.fn.getreg('/')}) <CR>", "Live grep with search term" },
    ["<leader>fgw"] = { "<cmd> lua require('telescope.builtin').live_grep({default_text=vim.fn.expand('<cword>')}) <CR>", "Live grep with current word" },

    ["<leader>gf<CR>"] = { "<cmd> lua require('telescope.builtin').find_files({}) <CR>", "Find files" },
    ["<leader>gf/"] = { "<cmd> lua require('telescope.builtin').find_files({default_text=vim.fn.getreg('/')}) <CR>", "Find files with search term" },
    ["<leader>gfw"] = { "<cmd> lua require('telescope.builtin').find_files({default_text=vim.fn.expand('<cword>')}) <CR>", "Find files with current word" },


    ["<leader>br<CR>"] = { ":execute '%s/' . input('Search term >') . '/' . input('Replace by >', '') . '/g | update' <CR>", "Replace pattern in current buffer" },
    ["<leader>br/"] = { ":execute '%s/' . input('Search term >', getreg('/')) . '/' . input('Replace by >', '') . '/g | update' <CR>", "Replace search term pattern in current buffer" },
    ["<leader>brw"] = { ":execute '%s/' . input('Search term >', expand('<cword>')) . '/' . input('Replace by >', '') . '/g | update' <CR>", "Replace current word pattern in current buffer" },

    -- Quickfix list
    ["<leader>ql"] = { "<cmd> Telescope quickfix <CR>", "Show qflist" },
    ["<leader>qn"] = { ":cnext<CR>", "Jump to next in qflist" },
    ["]q"] = { ":cnext<CR>", "Jump to next in qflist" },
    ["<leader>qp"] = { ":cprevious<CR>", "Jump to previous in qflist" },
    ["[q"] = { ":cprevious<CR>", "Jump to previous in qflist" },
    ["<leader>qc"] = { ":call setqflist([]) | cclose<CR>", "Clear qflist" },

    -- Quickfix replace all
    ["<leader>qr<CR>"] = { ":execute 'cfdo' '%s/' . input('Search term >') . '/' . input('Replace by >') . '/gI | update' <CR>", "Replace pattern in all qflist" },
    ["<leader>qr/"] = { ":execute 'cfdo' '%s/' . input('Search term >', getreg('/')) . '/' . input('Replace by >') . '/gI | update' <CR>", "Replace search term in all qflist" },
    ["<leader>qrw"] = { ":execute 'cfdo' '%s/' . input('Search term >', expand('<cword>')) . '/' . input('Replace by >') . '/gI | update' <CR>", "Replace current word in all qflist" },

    -- Quickfix "search"
    ["<leader>qs<CR>"] = { ":execute 'vimgrep' '/' . input('Pattern >') . '\\C/' '**/*' <CR>", "Add <> files in qflist" },
    ["<leader>qs/"] = { ":execute 'vimgrep' '/' . input('Pattern >', getreg('/')) . '\\C/' '**/*' <CR>", "Add search term files in qflist" },
    ["<leader>qsw"] = { ":execute 'vimgrep' '/' . input('Pattern >', expand('<cword>')) . '\\C/' '**/*' <CR>", "Add current word files in qflist" },

    -- Loclist list
    ["<leader>ll"] = { "<cmd> Telescope loclist <CR>", "Show loclist" },
    ["<leader>ln"] = { ":lnext<CR>", "Jump to next in loclist" },
    ["]l"] = { ":lnext<CR>", "Jump to next in loclist" },
    ["<leader>lp"] = { ":lprevious<CR>", "Jump to previous in loclist" },
    ["[l"] = { ":lprevious<CR>", "Jump to previous in loclist" },
    ["<leader>lc"] = { ":call setloclist([]) | lclose<CR>", "Clear loclist" },

    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>fx<CR>"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
    ["<leader>fx/"] = { "<cmd> lua require('telescope.builtin').current_buffer_fuzzy_find({default_text=vim.fn.getreg('/')}) <CR>", "Fuzzy find in current buffer with actual search" },
    ["<leader>fxw"] = { "<cmd> lua require('telescope.builtin').current_buffer_fuzzy_find({default_text=vim.fn.expand('<cword>')}) <CR>", "Fuzzy find in current buffer with current word" },

    ["<leader>wl"] = { "<cmd> Telescope workspaces <CR>", "Find workspaces" },

    ["<leader>gm"] = { "<cmd> lua require('custom.telescope').cpickers()<CR>", "Commonly used commands" },
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
    ["<leader>dw"] = { "<cmd>lua require('diaglist').open_all_diagnostics()<CR>", "Open all open buffers diagnostics in qflist" },
    ["<leader>d0"] = { "<cmd>lua require('diaglist').open_buffer_diagnostics()<CR>", "Open current buffer diagnostics in loclist" },

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

local all_modes = {
  -- Override all delete/yank/paste to use the registers M by default
  ["y"] = { "\"my", "Yank", { remap=false } },
  ["p"] = { "\"mp", "Paste", { remap=false } },
  ["d"] = { "\"md", "Delete", { remap=false } },

  ["<leader>y"] = { "\"+y", "Yank into system register", { remap=false } },
  ["<leader>p"] = { "\"+p", "Paste from system register", { remap=false } },
}

M.general[{"n", "v"}] = all_modes

return M
