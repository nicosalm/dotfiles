return {
    {
        "saghen/blink.cmp",
        version = "1.*",
        opts = {
            keymap = {
                preset = "default",
                ["<S-j>"] = { "select_next", "fallback" },
                ["<S-k>"] = { "select_prev", "fallback" },
            },
            sources = { default = { "lsp", "path", "buffer" } },
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 200 },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        config = function()
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                    },
                },
            })

            vim.lsp.config("basedpyright", {
                settings = {
                    basedpyright = { disableOrganizeImports = true },
                },
            })

            vim.lsp.enable({ "lua_ls", "clangd", "rust_analyzer", "ts_ls", "basedpyright", "ruff" })
        end,
    },
}
