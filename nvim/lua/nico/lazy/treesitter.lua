return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local large_file_notified = {}

        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                "c", "cpp", "typescript", "tsx", "javascript", "lua", "rust", "python", "bash",
                "markdown", "markdown_inline",
            },
            sync_install = false,
            -- Disabled: auto_install spawns a curl+tar job per previewed file
            -- (e.g. fff.nvim previews on <leader>pf), and concurrent jobs race on
            -- the shared parser cache, producing spurious tar extraction errors.
            auto_install = false,
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
