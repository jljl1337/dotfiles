local function retab(old_size, new_size)
    local buf_expandtab = vim.bo.expandtab

    -- Step 1: treat existing indentation as tabs of the old width, convert to real tabs
    vim.bo.tabstop = old_size
    vim.bo.shiftwidth = old_size
    vim.bo.expandtab = false
    vim.cmd("retab!")

    -- Step 2: reinterpret those tabs at the new width, convert back to spaces
    vim.bo.tabstop = new_size
    vim.bo.shiftwidth = new_size
    vim.bo.expandtab = true
    vim.cmd("retab!")

    -- restore original expandtab setting if you don't want to force spaces
    -- vim.bo.expandtab = buf_expandtab
end

-- Keymap: prompts for old and new size each time
vim.keymap.set("n", "<leader>rt", function()
    local old_size = tonumber(vim.fn.input("Old tab size: "))
    local new_size = tonumber(vim.fn.input("New tab size: "))
    if old_size and new_size then
        retab(old_size, new_size)
        print(("Retabbed from %d to %d"):format(old_size, new_size))
    else
        print("Invalid input, aborted")
    end
end, { desc = "Retab buffer with prompted sizes" })
