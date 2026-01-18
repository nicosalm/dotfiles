return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    config = function()
        -- Function to set our markdown highlights
        local function set_markdown_highlights()
            if vim.g.colors_name == "elflord" then
                vim.api.nvim_set_hl(0, 'RenderMarkdownCode', {
                    bg = '#161616',
                    fg = 'NONE',
                    default = false
                })
                vim.api.nvim_set_hl(0, 'RenderMarkdownCodeInline', {
                    bg = '#161616',
                    fg = 'NONE',
                    default = false
                })
            end
        end

        -- Create a command to manually reset highlights
        vim.api.nvim_create_user_command('FixMarkdownHighlights', set_markdown_highlights, {})

        -- Set highlights when colorscheme changes
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "*",
            callback = set_markdown_highlights
        })

        -- Setup the plugin
        require('render-markdown').setup({
            code = {
                highlight = 'RenderMarkdownCode',
                highlight_inline = 'RenderMarkdownCodeInline',
                style = 'normal',
                disable_background = false,
            }
        })

        -- Set highlights after plugin setup
        set_markdown_highlights()
    end
}
