return {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    opts = {
        pickers = {
            find_files = {
                hidden = true,
                file_ignore_patterns = { ".git/", "node_modules/" },
            },
            live_grep = {
                file_ignore_patterns = { 'node_modules', '.git', '.venv' },
                additional_args = function(_)
                    return { "--hidden" }
                end
            },
        }
    }
}
