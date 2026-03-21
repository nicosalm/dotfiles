return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
        -- error handling
        local ok, treesitter_configs = pcall(require, 'nvim-treesitter.configs')
        if not ok then
            vim.notify("nvim-treesitter.configs not found", vim.log.levels.ERROR)
            return
        end

        treesitter_configs.setup({
            -- list of parser names, or "all"
            ensure_installed = {
                "c", "cpp", "typescript", "javascript", "lua", "rust", "python", "bash",
            },
            sync_install = false,
            auto_install = true,
            indent = {
                enable = true,
            },
            highlight = {
                enable = true,
                disable = function(lang, buf)
                    -- Add nil check for buf
                    if not buf or buf == 0 then
                        return false
                    end

                    if lang == "html" then
                        return true
                    end

                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        vim.notify(
                            "file larger than 100KB: treesitter disabled for performance",
                            vim.log.levels.WARN,
                            {title = "Treesitter"}
                        )
                        return true
                    end
                    return false
                end,
                additional_vim_regex_highlighting = { "markdown" },
            },
        })

    end
}
