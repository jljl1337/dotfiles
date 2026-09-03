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

            -- Spell checking
            vim.lsp.enable("typos_lsp")

            -- JSON schema support
            vim.lsp.config("jsonls", {
                settings = {
                    json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
            vim.lsp.enable("jsonls")

            -- YAML schema support
            vim.lsp.config("yamlls", {
                settings = {
                    yaml = {
                        schemaStore = {
                            -- You must disable built-in schemaStore support if you want to use
                            -- this plugin and its advanced options like `ignore`.
                            enable = false,
                            -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                            url = "",
                        },
                        schemas = require('schemastore').yaml.schemas(),
                    },
                },
            })
            vim.lsp.enable("yamlls")

            -- Lua
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
            vim.lsp.enable("lua_ls")

            -- Python
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
            vim.lsp.enable("pyright")

            -- Golang
            vim.lsp.config("gopls", {
                settings = {
                    gopls = {
                        analyses = { unusedparams = true },
                        staticcheck = true,
                    },
                },
            })
            vim.lsp.enable("gopls")
        end,
    },
}
