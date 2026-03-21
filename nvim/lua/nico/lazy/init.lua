return {

    {
        "blazkowolf/gruber-darker.nvim",
        lazy = false,
        priority = 1000,
        opts = { italic = { strings = false, comments = true } },
    },
    { "nyoom-engineering/oxocarbon.nvim", lazy = true },

    { 'wakatime/vim-wakatime', lazy = false },
    {
        "vyfor/cord.nvim",
        lazy = false,
        build = ":Cord update",
        opts = {},
    },
    {
        "NvChad/nvim-colorizer.lua",
        ft = { "css", "javascript", "html" },
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
    "tpope/vim-repeat",
    "tpope/vim-sleuth",

    {
        'saecki/crates.nvim',
        tag = 'stable',
        ft = "toml",
        config = function()
            require('crates').setup()
        end,
    },

}
