return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- For auto complete
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- shared defaults for ALL servers
            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            -- Per-server settings
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            })

            vim.lsp.config("pyright", {
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "basic",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })

            vim.lsp.config("rust_analyzer", {
                settings = {
                    ["rust-analyzer"] = {
                        cargo = { allFeatures = true },
                        checkOnSave = { command = "clippy" },
                    },
                },
            })

            vim.lsp.config("ts_ls", {})

            vim.lsp.config("gopls", {
                settings = {
                    gopls = {
                        analyses = { unusedparams = true },
                        staticcheck = true,
                    },
                },
            })

            vim.lsp.config("clangd", {
                cmd = { "clangd", "--background-index", "--clang-tidy" },
            })
        end,
    },
}
