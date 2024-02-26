local M = {}

M.textobjects = {
  select = {
    enable = true,

    -- Automatically jump forward to textobj, similar to targets.vim
    lookahead = true,

    keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
      ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
      ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
      ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

      ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
      ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

      ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
      ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

      ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
      ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

      ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
      ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

      ["am"] = { query = "@function.outer", desc = "Select outer part of a function def" },
      ["im"] = { query = "@function.inner", desc = "Select inner part of a function def" },

      ["ak"] = { query = "@class.outer", desc = "Select outer part of a class" },
      ["ik"] = { query = "@class.inner", desc = "Select inner part of a class" },

      ["ac"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
      ["ic"] = { query = "@comment.inner", desc = "Select inner part of a comment" },
    },
  },
  move = {
    enable = true,
    -- Whether to set jumps in the jumplist
    set_jumps = true,
    goto_next_start = {
      ["]a"] = { query = "@parameter.outer", desc = "Goto next start outer parameter" },
      ["]i"] = { query = "@conditional.outer", desc = "Goto next start outer conditional" },
      ["]l"] = { query = "@loop.outer", desc = "Goto next start outer loop" },
      ["]f"] = { query = "@call.outer", desc = "Goto next start outer call" },
      ["]m"] = { query = "@function.outer", desc = "Goto next start outer function" },
      ["]k"] = { query = "@class.outer", desc = "Goto next start outer class" },
      ["]c"] = { query = "@comment.outer", desc = "Goto next start outer comment" },
    },
    goto_next_end = {
      ["]A"] = { query = "@parameter.outer", desc = "Goto next end outer parameter" },
      ["]I"] = { query = "@conditional.outer", desc = "Goto next end outer conditional" },
      ["]L"] = { query = "@loop.outer", desc = "Goto next end outer loop" },
      ["]F"] = { query = "@call.outer", desc = "Goto next end outer call" },
      ["]M"] = { query = "@function.outer", desc = "Goto next end outer function" },
      ["]K"] = { query = "@class.outer", desc = "Goto next end outer class" },
      ["]C"] = { query = "@comment.outer", desc = "Goto next end outer comment" },
    },
    goto_previous_start = {
      ["[a"] = { query = "@parameter.outer", desc = "Goto previous start outer parameter" },
      ["[i"] = { query = "@conditional.outer", desc = "Goto previous start outer conditional" },
      ["[l"] = { query = "@loop.outer", desc = "Goto previous start outer loop" },
      ["[f"] = { query = "@call.outer", desc = "Goto previous start outer call" },
      ["[m"] = { query = "@function.outer", desc = "Goto previous start outer function" },
      ["[k"] = { query = "@class.outer", desc = "Goto previous start outer class" },
      ["[c"] = { query = "@comment.outer", desc = "Goto previous start outer comment" },
    },
    goto_previous_end = {
      ["[A"] = { query = "@parameter.outer", desc = "Goto previous end outer parameter" },
      ["[I"] = { query = "@conditional.outer", desc = "Goto previous end outer conditional" },
      ["[L"] = { query = "@loop.outer", desc = "Goto previous end outer loop" },
      ["[F"] = { query = "@call.outer", desc = "Goto previous end outer call" },
      ["[M"] = { query = "@function.outer", desc = "Goto previous end outer function" },
      ["[K"] = { query = "@class.outer", desc = "Goto previous end outer class" },
      ["[C"] = { query = "@comment.outer", desc = "Goto previous end outer comment" },
    },
  },

  swap = {
    enable = true,

    swap_next = {
      ["<leader>na"] = { query = "@parameter.inner", desc = "Swap with next inner parameter" },
      ["<leader>ni"] = { query = "@conditional.outer", desc = "Swap with next outer conditional" },
      ["<leader>nl"] = { query = "@loop.outer", desc = "Swap with next outer loop" },
      ["<leader>nf"] = { query = "@call.outer", desc = "Swap with next outer call" },
      ["<leader>nm"] = { query = "@function.outer", desc = "Swap with next outer function" },
      ["<leader>nk"] = { query = "@class.outer", desc = "Swap with next outer class" },
      ["<leader>nc"] = { query = "@comment.outer", desc = "Swap with next outer comment" },

      ["<leader>nA"] = { query = "@parameter.outer", desc = "Swap with next outer parameter" },
      ["<leader>nI"] = { query = "@conditional.inner", desc = "Swap with next inner conditional" },
      ["<leader>nL"] = { query = "@loop.inner", desc = "Swap with next inner loop" },
      ["<leader>nF"] = { query = "@call.inner", desc = "Swap with next inner call" },
      ["<leader>nM"] = { query = "@function.inner", desc = "Swap with next inner function" },
      ["<leader>nK"] = { query = "@class.inner", desc = "Swap with next inner class" },
      ["<leader>nC"] = { query = "@comment.inner", desc = "Swap with next inner comment" },
    },
    swap_previous = {
      ["<leader>pa"] = { query = "@parameter.inner", desc = "Swap with previous inner parameter" },
      ["<leader>pi"] = { query = "@conditional.outer", desc = "Swap with previous outer conditional" },
      ["<leader>pl"] = { query = "@loop.outer", desc = "Swap with previous outer loop" },
      ["<leader>pf"] = { query = "@call.outer", desc = "Swap with previous outer call" },
      ["<leader>pm"] = { query = "@function.outer", desc = "Swap with previous outer function" },
      ["<leader>pk"] = { query = "@class.outer", desc = "Swap with previous outer class" },
      ["<leader>pc"] = { query = "@comment.outer", desc = "Swap with previous outer comment" },

      ["<leader>pA"] = { query = "@parameter.outer", desc = "Swap with previous outer parameter" },
      ["<leader>pI"] = { query = "@conditional.inner", desc = "Swap with previous inner conditional" },
      ["<leader>pL"] = { query = "@loop.inner", desc = "Swap with previous inner loop" },
      ["<leader>pF"] = { query = "@call.inner", desc = "Swap with previous inner call" },
      ["<leader>pM"] = { query = "@function.inner", desc = "Swap with previous inner function" },
      ["<leader>pK"] = { query = "@class.inner", desc = "Swap with previous inner class" },
      ["<leader>pC"] = { query = "@comment.inner", desc = "Swap with previous inner comment" },
    },
  }
}

-- local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

-- Repeat movement with ; and ,
-- vim.keymap.set({"n", "x", "o"}, ",", ts_repeat_move.repeat_last_move_next)
-- vim.keymap.set({"n", "x", "o"}, ",", ts_repeat_move.repeat_last_move_previous)

-- Optionnally, make builtin f, F, t, T also repeatable with ; and ,
-- vim.keymap.set({"n", "x", "o"}, "f", ts_repeat_move.builtin_f)
-- vim.keymap.set({"n", "x", "o"}, "F", ts_repeat_move.builtin_F)
-- vim.keymap.set({"n", "x", "o"}, "t", ts_repeat_move.builtin_t)
-- vim.keymap.set({"n", "x", "o"}, "T", ts_repeat_move.builtin_T)

return M
