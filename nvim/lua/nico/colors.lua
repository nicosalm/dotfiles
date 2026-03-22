local themes = {
    { scheme = "gruber-darker", plugin = nil },
    { scheme = "oxocarbon",     plugin = "oxocarbon.nvim" },
}
local current = 2

local hl = {
    ["gruber-darker"] = {
        error  = "#f43841",
        warn   = "#ffdd33",
        info   = "#96a6c8",
        diff_a = "#1a2e1a",
        diff_c = "#1a1a2e",
        diff_d = "#2e1a1a",
        diff_t = "#2a2a4a",
    },
    ["oxocarbon"] = {
        error  = "#ee5396",
        warn   = "#ffe97b",
        info   = "#78a9ff",
        diff_a = "#1a2e1a",
        diff_c = "#1a1a2e",
        diff_d = "#2e1a1a",
        diff_t = "#1e2a4a",
    },
}

local function apply_theme(idx)
    local t = themes[idx]
    if t.plugin then require("lazy").load({ plugins = { t.plugin } }) end
    vim.cmd.colorscheme(t.scheme)
    local c = hl[t.scheme]
    vim.api.nvim_set_hl(0, "DiagnosticError",          { fg = c.error })
    vim.api.nvim_set_hl(0, "DiagnosticWarn",           { fg = c.warn })
    vim.api.nvim_set_hl(0, "DiagnosticInfo",           { fg = c.info })
    vim.api.nvim_set_hl(0, "DiagnosticHint",           { fg = c.info })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = c.error, underline = true })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  { sp = c.warn,  underline = true })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",  { sp = c.info,  underline = true })
    vim.api.nvim_set_hl(0, "DiffAdd",    { bg = c.diff_a })
    vim.api.nvim_set_hl(0, "DiffChange", { bg = c.diff_c })
    vim.api.nvim_set_hl(0, "DiffDelete", { bg = c.diff_d })
    vim.api.nvim_set_hl(0, "DiffText",   { bg = c.diff_t })
end

apply_theme(current)

vim.keymap.set("n", "<leader>cs", function()
    current = (current % #themes) + 1
    apply_theme(current)
    vim.notify(themes[current].scheme, vim.log.levels.INFO)
end, { desc = "cycle colorscheme" })
