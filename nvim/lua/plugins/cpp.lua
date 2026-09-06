-- C/C++ formatting: LazyVim's clangd extra doesn't wire up a conform.nvim
-- formatter for c/cpp, so it was falling back to clangd's LSP formatting,
-- which uses `--fallback-style=llvm` (2-space indent) whenever a project
-- has no .clang-format file. This switches to explicit clang-format via
-- conform, using each project's .clang-format when present, and otherwise
-- falling back to LLVM style with a 4-space indent instead of 2.
local function clang_format_style_args(ctx)
  local found = vim.fs.find(".clang-format", { path = ctx.dirname, upward = true })[1]
  if found then
    return { "-style=file" }
  end
  return {
    "-style={BasedOnStyle: LLVM, IndentWidth: 4, BinPackArguments: false, BinPackParameters: false, AlignAfterOpenBracket: BlockIndent}",
  }
end

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
      formatters = {
        ["clang-format"] = {
          args = function(_, ctx)
            return vim.list_extend({ "-assume-filename", "$FILENAME" }, clang_format_style_args(ctx))
          end,
          range_args = function(_, ctx)
            local util = require("conform.util")
            local start_offset, end_offset = util.get_offsets_from_range(ctx.buf, ctx.range)
            local length = end_offset - start_offset
            local args = {
              "-assume-filename",
              "$FILENAME",
              "--offset",
              tostring(start_offset),
              "--length",
              tostring(length),
            }
            return vim.list_extend(args, clang_format_style_args(ctx))
          end,
        },
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "clang-format" } },
  },
}
