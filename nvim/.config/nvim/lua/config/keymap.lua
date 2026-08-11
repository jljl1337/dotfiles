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
vim.keymap.set('n', '<leader>/', '<cmd>nohlsearch<CR>')

-- Navigate splits seamlessly using Ctrl + h/j/k/l
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom split' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top split' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right split' })

-- Using <leader> + 1..9 to navigate
for i = 1, 9 do
    vim.keymap.set('n', '<leader>' .. i .. '', i .. '<C-w>w', { desc = 'Focus window ' .. i })
end

-- Save
vim.keymap.set("n", "<C-s>", ":w ++p<CR>")
vim.keymap.set("n", "<leader>s", ":wa ++p<CR>")

-- Quit
vim.keymap.set("n", "<C-q>", ":q<CR>")
vim.keymap.set("n", "<S-q>", ":q!<CR>")
vim.keymap.set("n", "<leader>q", ":qa<CR>")
vim.keymap.set("n", "<leader>Q", ":qa!<CR>")

-- Diagnostic
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Show line diagnostics" })
vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { desc = 'Code Action' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end)
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end)

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
vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>g', require('telescope.builtin').live_grep, { desc = 'Telescope live grep' })

-- Lsp
vim.keymap.set("n", "gd", require("definition-or-references").definition_or_references, { silent = true })

-- ToggleTerm
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle terminal" })
-- Escape from terminal mode
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Neogit
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Show Neogit UI" })
