return {

    {
        "blazkowolf/gruber-darker.nvim",
        lazy = false,
        priority = 1000,
        opts = { italic = { strings = false, comments = true } },
    },

    { 'wakatime/vim-wakatime', lazy = false },
    "andweeb/presence.nvim",
    "tpope/vim-commentary",
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                filetypes = { "css", "javascript", "html" },
                user_default_options = { mode = "background" },
            })
        end,
    },

    -- ys iw " (you surround)
    -- cs " [  (change surround)
    -- ds "    (delete surround)
    -- yss "   (wrap sentence in ")
    -- selection in visual mode + shift+S <p> wrap selection in p tag
    -- left bracket has space, right does not
    "tpope/vim-surround",

    {
        'saecki/crates.nvim',
        tag = 'stable',
        config = function()
            require('crates').setup()
        end,
    },

}
