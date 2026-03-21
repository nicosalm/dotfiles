vim.cmd.colorscheme("gruber-darker")

-- keep TODO/NOTE visible even in plain buffers without treesitter
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
    group = vim.api.nvim_create_augroup("todo_highlight", { clear = true }),
    callback = function()
        for _, m in ipairs(vim.fn.getmatches()) do
            if m.group == "TODO" then return end
        end
        vim.fn.matchadd("TODO", [[\<\(TODO\|NOTE\)\>]], 200)
    end,
})

vim.api.nvim_set_hl(0, "TODO",           { link = "DiagnosticWarn" })
vim.api.nvim_set_hl(0, "@comment.todo",  { link = "DiagnosticWarn" })
vim.api.nvim_set_hl(0, "@comment.note",  { link = "DiagnosticHint" })

vim.api.nvim_set_hl(0, "DiagnosticError",          { fg = "#f43841" })
vim.api.nvim_set_hl(0, "DiagnosticWarn",           { fg = "#ffdd33" })
vim.api.nvim_set_hl(0, "DiagnosticInfo",           { fg = "#96a6c8" })
vim.api.nvim_set_hl(0, "DiagnosticHint",           { fg = "#96a6c8" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = "#f43841", underline = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  { sp = "#ffdd33", underline = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",  { sp = "#96a6c8", underline = true })

vim.api.nvim_set_hl(0, "DiffAdd",    { bg = "#1a2e1a" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = "#1a1a2e" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#2e1a1a" })
vim.api.nvim_set_hl(0, "DiffText",   { bg = "#2a2a4a" })
