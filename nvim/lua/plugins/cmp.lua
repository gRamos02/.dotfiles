return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        -- vim-style (hjkl) navigation through completion suggestions,
        -- in addition to the default <C-n>/<C-p> and <Up>/<Down>
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
      },
    },
  },
}
