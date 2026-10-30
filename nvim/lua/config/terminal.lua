local M = {}
local buffer
local window

local function layout()
  local width = math.max(1, math.min(math.floor(vim.o.columns * 0.85), vim.o.columns - 2))
  local height = math.max(1, math.min(math.floor(vim.o.lines * 0.75), vim.o.lines - vim.o.cmdheight - 2))
  return {
    relative = "editor",
    width = width,
    height = height,
    row = math.max(0, math.floor((vim.o.lines - height - 2) / 2)),
    col = math.max(0, math.floor((vim.o.columns - width - 2) / 2)),
    style = "minimal",
    border = "rounded",
    title = " terminal ",
    title_pos = "center",
  }
end

function M.toggle()
  if window and vim.api.nvim_win_is_valid(window) then
    vim.api.nvim_win_hide(window)
    window = nil
    return
  end

  local running = buffer and vim.api.nvim_buf_is_valid(buffer)
    and vim.bo[buffer].channel > 0
    and vim.fn.jobwait({ vim.bo[buffer].channel }, 0)[1] == -1
  if not running then
    buffer = vim.api.nvim_create_buf(false, true)
    vim.bo[buffer].bufhidden = "hide"
  end
  window = vim.api.nvim_open_win(buffer, true, layout())
  if not running then
    vim.fn.jobstart(vim.o.shell, { term = true })
  end
  vim.cmd("startinsert")
end

vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("UserFloatingTerminal", { clear = true }),
  callback = function()
    if window and vim.api.nvim_win_is_valid(window) then
      vim.api.nvim_win_set_config(window, layout())
    end
  end,
})

return M
