return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            suggestion = {
                auto_trigger = true,
                keymap = {
                    accept = "<Tab>",
                }
            },
            filetypes = {
                -- disable for .env files
                sh = function()
                    local filename = vim.fs.basename(vim.api.nvim_buf_get_name(0))
                    if string.find(filename, ".env", 1, true) then
                        return false
                    end
                    return true
                end,
                env = false,
                ["*"] = true,
            },
        })
    end,
}
