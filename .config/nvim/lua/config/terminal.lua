-- Custom terminal window
local term_buf = nil
local term_win = nil
local TERM_HEIGHT = 20

local function is_tree_open()
    local ok = pcall(require, "nvim-tree.api")
    if not ok then return false end
    return require("nvim-tree.view").is_visible()
end

-- Core logic: assumes tree is currently closed, creates terminal split
local function open_terminal_split()
    vim.cmd("botright split")
    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
        vim.api.nvim_set_current_buf(term_buf)
    else
        vim.cmd("terminal")
        term_buf = vim.api.nvim_get_current_buf()
    end
    term_win = vim.api.nvim_get_current_win()

    -- fixed height: Vim's auto-equalize will skip this window from now on
    vim.wo[term_win].winfixheight = true
    vim.api.nvim_win_set_height(term_win, TERM_HEIGHT)

    vim.cmd("startinsert")
end

local function toggle_terminal()
    if term_win and vim.api.nvim_win_is_valid(term_win) then
        if vim.api.nvim_get_current_win() == term_win then
            vim.api.nvim_win_hide(term_win)
            term_win = nil
            return
        else
            vim.api.nvim_set_current_win(term_win)
            vim.cmd("startinsert")
            return
        end
    end

    local tree_was_open = is_tree_open()
    local api = tree_was_open and require("nvim-tree.api") or nil

    if tree_was_open then
        api.tree.close()
    end

    open_terminal_split()

    if tree_was_open then
        api.tree.open({ focus = false })
        vim.api.nvim_set_current_win(term_win)
        vim.cmd("startinsert")
        -- reassert in case tree.open forces a layout pass
        vim.api.nvim_win_set_height(term_win, TERM_HEIGHT)
    end
end
_G.toggle_terminal = toggle_terminal
