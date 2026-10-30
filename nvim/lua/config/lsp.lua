local data = vim.fn.stdpath("data")
vim.env.PATH = vim.env.PATH .. ":" .. data .. "/mason/bin:" .. data .. "/lsp-tools/node_modules/.bin"

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
vim.lsp.config("clangd", {
  cmd = { "clangd", "--clang-tidy" },
})
vim.lsp.enable({ "ts_ls", "gopls", "pyright", "clangd" })

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  update_in_insert = false,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLsp", { clear = true }),
  callback = function(event)
    local function map(key, action, desc)
      vim.keymap.set("n", key, action, { buffer = event.buf, desc = desc })
    end
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gr", vim.lsp.buf.references, "Find references")
    map("gi", vim.lsp.buf.implementation, "Go to implementation")
    map("K", vim.lsp.buf.hover, "Hover documentation")
    map("<leader>cr", vim.lsp.buf.rename, "Rename symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
  end,
})
