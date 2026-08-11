return {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
        "nvim-treesitter/nvim-treesitter", -- optional, for icons/highlighting
        "nvim-tree/nvim-web-devicons",     -- optional
    },
    config = function()
        require("lspsaga").setup({
            ui = {
                border = "rounded",
            },
            lightbulb = {
                enable = false,
            },
        })
    end,
}
