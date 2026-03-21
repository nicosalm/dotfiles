local servers = { "lua_ls", "clangd", "rust_analyzer", "ts_ls", "basedpyright", "ruff" }

return {
    {
        "saghen/blink.cmp",
        version = "1.*",
        lazy = true,
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
        "mason-org/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim" },
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            ensure_installed = servers,
            automatic_enable = false, -- we call vim.lsp.enable manually
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp", "mason-org/mason-lspconfig.nvim" },
        event = { "BufReadPre", "BufNewFile" },
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

            vim.lsp.enable(servers)
        end,
    },
}
