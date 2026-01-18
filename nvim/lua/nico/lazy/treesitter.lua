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
                "typescript", "javascript", "lua", "rust", "go", "python", "bash",
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
                        print("disabled")
                        return true
                    end

                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
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

        -- error handling for parser config
        local ok_parser, treesitter_parser_config = pcall(require, "nvim-treesitter.parsers")
        if ok_parser then
            local parser_configs = treesitter_parser_config.get_parser_configs()
            parser_configs.templ = {
                install_info = {
                    url = "https://github.com/vrischmann/tree-sitter-templ.git",
                    files = {"src/parser.c", "src/scanner.c"},
                    branch = "master",
                },
            }

            -- error handling for language registration
            local ok_lang = pcall(vim.treesitter.language.register, "templ", "templ")
            if not ok_lang then
                vim.notify("Failed to register templ language", vim.log.levels.WARN)
            end
        else
            vim.notify("Failed to load treesitter parsers", vim.log.levels.WARN)
        end
    end
}
