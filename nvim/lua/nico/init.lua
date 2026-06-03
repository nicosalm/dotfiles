
require("nico.set")
require("nico.remap")
require("nico.lazy_init")
require("nico.colors")

local augroup = vim.api.nvim_create_augroup
local NicoGroup = augroup('Nico', { clear = true })

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', { clear = true })


autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.hl.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = NicoGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd("LspAttach", {
    group = NicoGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    end
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = { current_line = true },
})

-- statusline
vim.opt.laststatus = 3
vim.opt.statusline = "%<%{expand('%:~')}(%(%l:%v%))"
    .. " %{exists('b:git_branch') ? b:git_branch : ''}"
    .. " %h%w%{&modified ?  '[MODIFIED]' : ''}%r"
    .. " %=%P"

autocmd({ "BufWinEnter" }, {
    desc = "Get git branch of opened buffer for statusline",
    group = augroup("statusline_git_branch", { clear = true }),
    callback = function()
        if vim.b.git_branch ~= nil then return end
        local file_path = vim.fn.expand("%:p:h")
        local stdout = vim.uv.new_pipe(false)
        local chunks = {}
        local handle
        handle = vim.uv.spawn("git", {
            args = { "-C", file_path, "branch", "--show-current" },
            stdio = { nil, stdout, nil },
        }, function()
            stdout:close()
            if handle then handle:close() end
            local branch = vim.trim(table.concat(chunks))
            vim.schedule(function()
                vim.b.git_branch = #branch > 0 and string.format("git:(%s)", branch) or ""
            end)
        end)
        if handle then
            stdout:read_start(function(err, data)
                if not err and data then table.insert(chunks, data) end
            end)
        else
            stdout:close()
        end
    end,
})
