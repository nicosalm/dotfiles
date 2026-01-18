return {

    { "nvim-lua/plenary.nvim", name = "plenary" },
    { 'wakatime/vim-wakatime', lazy = false },
    "andweeb/presence.nvim",
    "tpope/vim-commentary",
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require 'colorizer'.setup {
                'css';
                'javascript';
                html = {
                    mode = 'foreground';
                }
            }
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
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup()
        end,
    },
    {
        'saecki/crates.nvim',
        tag = 'stable',
        config = function()
            require('crates').setup()
        end,
    },

    vim.keymap.set("n", "<leader>rn", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true })

}
