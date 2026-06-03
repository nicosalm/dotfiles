return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local large_file_notified = {}

        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                "c", "cpp", "typescript", "javascript", "lua", "rust", "python", "bash",
            },
            sync_install = false,
            auto_install = true,
            indent = { enable = true },
            highlight = {
                enable = true,
                disable = function(lang, buf)
                    if lang == "html" then return true end

                    local max_filesize = 100 * 1024
                    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        if not large_file_notified[buf] then
                            large_file_notified[buf] = true
                            vim.notify(
                                "file larger than 100KB: treesitter disabled for performance",
                                vim.log.levels.WARN,
                                { title = "Treesitter" }
                            )
                        end
                        return true
                    end
                    return false
                end,
                additional_vim_regex_highlighting = { "markdown" },
            },
        })
    end
}
