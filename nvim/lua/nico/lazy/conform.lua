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
        formatters = {
            stylua = {
                prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
            },
            ["clang-format"] = {
                prepend_args = { "--style={IndentWidth: 4, UseTab: Never}" },
            },
            prettierd = {
                prepend_args = { "--tab-width", "4" },
            },
            prettier = {
                prepend_args = { "--tab-width", "4" },
            },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },
    },
}
