-- Odin language support: syntax highlighting, LSP, formatting
return {
  -- Treesitter parser for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "odin" } },
  },

  -- LSP: ols (Odin Language Server)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ols = {
          mason = false, -- ols is not available via Mason; install via system package
          settings = {
            ols = {
              -- Point OLS at the Odin standard library so completions work out of the box.
              -- Project-specific settings can still be placed in an `ols.json` at the repo root.
              collections = { { name = "core", path = "/usr/lib/odin/core" } },
              -- Uncomment and tweak if you want stricter checking, e.g.:
              -- checker_args = "-strict-style",
            },
          },
        },
      },
    },
  },

  -- Formatter: odinfmt (built-in formatter config is already provided by conform.nvim)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        odin = { "odinfmt" },
      },
    },
  },
}
