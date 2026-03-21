return {
    "stevearc/conform.nvim",
    lazy = false,
    opts = {
        formatters_by_ft = {
            lua        = { "stylua" },
            rust       = { "rustfmt" },
            c          = { "clang-format" },
            cpp        = { "clang-format" },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            python     = { "ruff_format" },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },
    },
}
