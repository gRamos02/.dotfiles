return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.opt.background = "dark"
      vim.cmd.colorscheme("gruvbox")
    end,
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    dependencies = {
      { "nvim-mini/mini.icons", opts = {} },
    },
    opts = {
      explorer = { enabled = true },
      picker = {
        enabled = true,
        sources = {
          explorer = {
            hidden = true,
            layout = { preset = "sidebar" },
            win = {
              list = {
                keys = {
                  ["<C-h>"] = function() vim.cmd.wincmd("h") end,
                  ["<C-j>"] = function() vim.cmd.wincmd("j") end,
                  ["<C-k>"] = function() vim.cmd.wincmd("k") end,
                  ["<C-l>"] = function() vim.cmd.wincmd("l") end,
                },
              },
            },
          },
        },
      },
    },
    keys = {
      { "<leader>e", function() Snacks.explorer({ cwd = vim.fn.getcwd() }) end, desc = "Explorer (current directory)" },
      { "<leader><space>", function() Snacks.picker.files() end, desc = "Find files" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent files" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find buffers" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Search project text" },
      { "<leader>F", function() Snacks.picker.grep({ cwd = vim.fn.getcwd() }) end, desc = "Search directory text" },
      { "<leader>F", function() Snacks.picker.grep_word({ cwd = vim.fn.getcwd() }) end, mode = "x", desc = "Search selection in directory" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Search help" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer (keep pane)" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      delay = 300,
      triggers = { { "<leader>", mode = { "n", "x" } } },
      icons = { mappings = false },
      spec = {
        { "<leader>b", group = "Buffers" },
        { "<leader>c", group = "Code" },
        { "<leader>f", group = "Files" },
        { "<leader>s", group = "Search" },
        { "<leader>w", group = "Windows" },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    opts = {
      options = {
        mode = "buffers",
        numbers = "none",
        sort_by = "id",
        separator_style = "thin",
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
        modified_icon = "*",
        diagnostics = false,
        always_show_bufferline = true,
        close_command = function(buf) Snacks.bufdelete(buf) end,
        right_mouse_command = false,
        middle_mouse_command = false,
        custom_filter = function(buf)
          return vim.bo[buf].buftype == ""
        end,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    opts = {
      options = {
        theme = "gruvbox",
        globalstatus = true,
        icons_enabled = false,
        section_separators = "",
        component_separators = "|",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    opts = {
      keymap = {
        preset = "default",
        ["<C-Space>"] = false,
        ["<Tab>"] = { "select_and_accept", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
      },
      sources = { default = { "lsp", "path", "buffer" } },
      completion = {
        list = { selection = { preselect = false, auto_insert = false } },
        documentation = { auto_show = false },
        ghost_text = { enabled = false },
      },
      cmdline = { enabled = false },
    },
  },
  {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        desc = "Format current file",
      },
    },
    opts = {
      formatters = {
        black = {
          command = function(self, ctx)
            return require("conform.util").find_executable(
              { ".venv/bin/black", "venv/bin/black" },
              vim.fn.stdpath("data") .. "/format-tools/bin/black"
            )(self, ctx)
          end,
        },
      },
      default_format_opts = { timeout_ms = 3000 },
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        go = { "gofmt" },
        python = { "black" },
        lua = { "stylua" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("config.lsp")
    end,
  },
}
