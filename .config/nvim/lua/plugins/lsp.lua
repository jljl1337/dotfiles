return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            require("mason").setup()

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "rust_analyzer",
                    "ts_ls",
                    "gopls",
                    "templ",
                    "clangd",
                },
                automatic_enable = true,
            })

            require("mason-tool-installer").setup({
                ensure_installed = {
                    "goimports-reviser",
                },
            })

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

            -- Format on save (opt in per filetype below)
            -- local format_on_save_filetypes = { "go" }
            --
            -- vim.api.nvim_create_autocmd("LspAttach", {
            --     callback = function(args)
            --         local client = vim.lsp.get_client_by_id(args.data.client_id)
            --         local bufnr = args.buf
            --         local ft = vim.bo[bufnr].filetype
            --
            --         if vim.tbl_contains(format_on_save_filetypes, ft)
            --                 and client:supports_method("textDocument/formatting") then
            --             vim.api.nvim_create_autocmd("BufWritePre", {
            --                 buffer = bufnr,
            --                 callback = function()
            --                     vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 2000 })
            --                 end,
            --             })
            --         end
            --     end,
            -- })
        end,
    },
}
