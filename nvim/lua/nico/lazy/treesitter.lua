return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter').install({
            "c", "cpp", "typescript", "tsx", "javascript", "lua", "rust", "python", "bash",
            "markdown", "markdown_inline",
        })

        local large_file_notified = {}
        vim.api.nvim_create_autocmd('BufDelete', {
            callback = function(args) large_file_notified[args.buf] = nil end,
        })
        vim.api.nvim_create_autocmd('FileType', {
            callback = function(args)
                local buf = args.buf
                local ft = vim.bo[buf].filetype
                if ft == "html" then return end

                local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > 100 * 1024 then
                    if not large_file_notified[buf] then
                        large_file_notified[buf] = true
                        vim.notify(
                            "file larger than 100KB: treesitter disabled for performance",
                            vim.log.levels.WARN,
                            { title = "Treesitter" }
                        )
                    end
                    return
                end

                pcall(vim.treesitter.start, buf)
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end
}
