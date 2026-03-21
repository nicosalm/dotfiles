local themes = {
    { scheme = "gruber-darker", plugin = nil },
    { scheme = "oxocarbon",     plugin = "oxocarbon.nvim" },
}
local current = 1

local function apply_theme(idx)
    local t = themes[idx]
    if t.plugin then require("lazy").load({ plugins = { t.plugin } }) end
    vim.cmd.colorscheme(t.scheme)
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
end

apply_theme(current)

vim.keymap.set("n", "<leader>cs", function()
    current = (current % #themes) + 1
    apply_theme(current)
    vim.notify(themes[current].scheme, vim.log.levels.INFO)
end, { desc = "cycle colorscheme" })
