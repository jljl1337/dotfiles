local function retab(old_size, new_size, start_line, end_line)
  local buf_expandtab = vim.bo.expandtab

  -- build the range prefix, e.g. "5,12" -- empty means whole buffer
  local range = ""
  if start_line and end_line then
    range = string.format("%d,%d", start_line, end_line)
  end

  -- Step 1: treat existing indentation as tabs of the old width, convert to real tabs
  vim.bo.tabstop = old_size
  vim.bo.shiftwidth = old_size
  vim.bo.expandtab = false
  vim.cmd(range .. "retab!")

  -- Step 2: reinterpret those tabs at the new width, convert back to spaces
  vim.bo.tabstop = new_size
  vim.bo.shiftwidth = new_size
  vim.bo.expandtab = true
  vim.cmd(range .. "retab!")

  -- restore original expandtab setting if you don't want to force spaces
  -- vim.bo.expandtab = buf_expandtab
end

-- Normal mode: prompts for old and new size, retabs whole buffer
vim.keymap.set("n", "<leader>rt", function()
  local old_size = tonumber(vim.fn.input("Old tab size: "))
  local new_size = tonumber(vim.fn.input("New tab size: "))
  if old_size and new_size then
    retab(old_size, new_size)
    print(("Retabbed buffer from %d to %d"):format(old_size, new_size))
  else
    print("Invalid input, aborted")
  end
end, { desc = "Retab buffer with prompted sizes" })

-- Visual mode: prompts for old and new size, retabs only the selected lines
vim.keymap.set("x", "<leader>rt", function()
  -- grab the visual selection range before leaving visual mode
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  local old_size = tonumber(vim.fn.input("Old tab size: "))
  local new_size = tonumber(vim.fn.input("New tab size: "))
  if old_size and new_size then
    retab(old_size, new_size, start_line, end_line)
    print(("Retabbed lines %d-%d from %d to %d"):format(start_line, end_line, old_size, new_size))
  else
    print("Invalid input, aborted")
  end
end, { desc = "Retab selected lines with prompted sizes" })
