-- Highlight color codes in the buffer
return {
    "norcalli/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup({
            "*",
        })
    end,
}
