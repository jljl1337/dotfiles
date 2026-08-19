return {
    -- Prerequisite
    {
        "nvim-tree/nvim-web-devicons",
    },

    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus" },
        config = function()
            local function on_attach(bufnr)
                local api = require('nvim-tree.api')

                local function opts(desc)
                    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                -- load the default mappings first (optional but recommended)
                api.map.on_attach.default(bufnr)

                -- then override/add your own, scoped to this buffer only
                vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
                vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
            end

            require('nvim-tree').setup({
                on_attach = on_attach,
                filters = {
                    custom = { "^\\.git$" },
                },
                actions = {
                    change_dir = {
                        enable = true,
                        global = false,
                        restrict_above_cwd = true, -- Disables browsing paths above your current workspace
                    },
                },
                git = {
                    enable = true,
                    ignore = false,
                }
            })
        end,
    },
}
