-- gd: go to definition
-- K: hover docs
-- <leader>vws: workspace symbol search
-- <leader>vd: view diagnostics
-- [d: next diagnostic
-- ]d: prev diagnostic
-- <leader>vca: code actions
-- <leader>vrr: find references
-- <leader>vrn: rename symbol
-- <C-h>: signature help (insert mode)

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                htmldjango = { "djlint" },
            }
        })

        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "ts_ls",
                "ty",
            },
            handlers = {
                function(server_name) -- default handler
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["rust_analyzer"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.rust_analyzer.setup({
                        capabilities = capabilities,
                        settings = {
                            ["rust-analyzer"] = {
                                completion = {
                                    snippets = "none",  -- Disable snippets to avoid the error
                                },
                                -- Alternative: you can also try this instead of the above
                                -- completion = {
                                --     postfix = {
                                --         enable = false
                                --     }
                                -- }
                            }
                        }
                    })
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                },
                                workspace = {
                                    checkThirdParty = false,
                                },
                                telemetry = {
                                    enable = false,
                                },
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['K'] = cmp.mapping.select_prev_item(cmp_select),
                ['J'] = cmp.mapping.select_next_item(cmp_select),
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            update_in_insert = false,
            underline = true,
            severity_sort = false,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
