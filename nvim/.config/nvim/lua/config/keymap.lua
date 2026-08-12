-- nvim general keymaps
-- Insert mode: jk -> Escape
vim.keymap.set("i", "jk", "<Esc>")

-- Visual mode: indent and keep selection
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Normal mode: indent
vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", ">", ">>")

-- Remove highlight after search in file
vim.keymap.set('n', '<leader><esc>', '<cmd>nohlsearch<CR>')

-- Navigate splits seamlessly using Ctrl + h/j/k/l
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom split' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top split' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right split' })

-- Toggle comment
vim.keymap.set('n', '<leader>/', 'gcc', { remap = true, desc = 'Toggle comment (line)' })
vim.keymap.set('v', '<leader>/', 'gc', { remap = true, desc = 'Toggle comment (selection)' })

-- Using <leader> + 1..9 to navigate
local function focus_window(n)
    -- filetypes to treat as "tree" and skip
    local tree_filetypes = {
        NvimTree = true,
        ['neo-tree'] = true,
        ['neo-tree-popup'] = true,
        minifiles = true,
        oil = true,
    }

    local wins = vim.api.nvim_tabpage_list_wins(0)
    local candidates = {}

    for _, win in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })
        if not tree_filetypes[ft] then
            table.insert(candidates, win)
        end
    end

    -- sort by position so numbering matches visual layout (top-to-bottom, left-to-right)
    table.sort(candidates, function(a, b)
        local pa = vim.api.nvim_win_get_position(a)
        local pb = vim.api.nvim_win_get_position(b)
        if pa[1] == pb[1] then
            return pa[2] < pb[2]
        end
        return pa[1] < pb[1]
    end)

    if candidates[n] then
        vim.api.nvim_set_current_win(candidates[n])
    end
end

for i = 1, 9 do
    vim.keymap.set('n', '<leader>' .. i, function()
        focus_window(i)
    end, { desc = 'Focus window ' .. i .. ' (skip tree)' })
end

-- Save
vim.keymap.set("n", "<C-s>", ":w ++p<CR>")
vim.keymap.set("n", "<leader>s", ":wa ++p<CR>")

-- Quit
vim.keymap.set("n", "<C-q>", ":q<CR>")
vim.keymap.set("n", "<S-q>", ":q!<CR>")
vim.keymap.set("n", "<leader>q", ":qa<CR>")
vim.keymap.set("n", "<leader>Q", ":qa!<CR>")

-- Change without copying the text
vim.keymap.set({ "n", "x" }, "c", '"_c')
vim.keymap.set({ "n", "x" }, "C", '"_C')

-- Plugins keymaps

-- The keymaps of the following plugins are configured in their corresponding
-- file:
--
-- nvim-cmp (auto complete)

-- keymaps when tree is focus are managed in the plugin file as it open other
-- files after pressing l when editing file
vim.keymap.set('n', '<leader>e', function()
    local api = require('nvim-tree.api')
    if api.tree.is_tree_buf() then
        api.tree.close()
    else
        api.tree.focus()
    end
end, { desc = 'Toggle/Focus nvim-tree' })

-- Lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy" })

-- Mason
vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Open Mason" })

-- telescope
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Telescope live grep' })

-- Lspsaga
vim.keymap.set('n', ']d', "<cmd>Lspsaga diagnostic_jump_prev<CR>")
vim.keymap.set('n', '[d', "<cmd>Lspsaga diagnostic_jump_next<CR>")
vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>")
vim.keymap.set("n", "<leader>a", "<cmd>Lspsaga code_action<CR>")
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
vim.keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>")
vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")

-- ToggleTerm
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle terminal" })
-- Escape from terminal mode
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Neogit
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Show Neogit UI" })
