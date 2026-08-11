return {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy", -- or use keys/cmd for lazier loading
    opts = {
        -- size = function(term)
        --     if term.direction == "horizontal" then
        --         return 15
        --     elseif term.direction == "vertical" then
        --         return vim.o.columns * 0.4
        --     end
        -- end,
        -- open_mapping = [[<c-\>]], -- toggle with Ctrl+\
        -- hide_numbers = true,
        -- shade_terminals = true,
        -- shading_factor = 2,
        -- start_in_insert = true,
        -- insert_mappings = true,
        -- terminal_mappings = true,
        -- persist_size = true,
        -- persist_mode = true,
        -- direction = "float", -- "vertical" | "horizontal" | "tab" | "float"
        -- close_on_exit = true,
        -- shell = vim.o.shell,
        -- float_opts = {
        --     border = "curved",
        --     winblend = 0,
        -- },
    },
}
