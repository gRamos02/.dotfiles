for _, direction in ipairs({ "h", "j", "k", "l" }) do
  vim.keymap.set("n", "<C-" .. direction .. ">", "<Cmd>wincmd " .. direction .. "<CR>", {
    desc = "Focus pane " .. direction,
  })
  vim.keymap.set("t", "<C-" .. direction .. ">", "<C-\\><C-n><Cmd>wincmd " .. direction .. "<CR>", {
    desc = "Focus pane " .. direction,
  })
end

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Terminal normal mode" })
vim.keymap.set({ "n", "i" }, "<C-s>", "<Cmd>write<CR>", { desc = "Save current file" })
vim.keymap.set("n", "<leader>q", "<Cmd>confirm qall<CR>", { desc = "Quit Neovim (confirm unsaved changes)" })
vim.keymap.set("n", "<leader>wv", "<Cmd>vsplit<CR>", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>ws", "<Cmd>split<CR>", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>w=", "<Cmd>wincmd =<CR>", { desc = "Equalize panes" })
vim.keymap.set("n", "<leader>ww", "<C-w>w", { desc = "Next pane" })
vim.keymap.set("n", "<S-h>", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<S-l>", "<Cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
vim.keymap.set("x", "<", "<gv", { desc = "Indent left (keep selection)" })
vim.keymap.set("x", ">", ">gv", { desc = "Indent right (keep selection)" })

for _, key in ipairs({ "<C-`>", "<C-Space>", "<C-@>" }) do
  vim.keymap.set({ "n", "i", "t" }, key, function()
    require("config.terminal").toggle()
  end, { desc = "Toggle terminal" })
end

for _, key in ipairs({ "<C-/>", "<C-_>" }) do
  vim.keymap.set("n", key, "gcc", { remap = true, desc = "Toggle comment" })
  vim.keymap.set("x", key, "gc", { remap = true, desc = "Toggle comments" })
  vim.keymap.set("i", key, "<C-o>gcc", { remap = true, desc = "Toggle comment" })
end
