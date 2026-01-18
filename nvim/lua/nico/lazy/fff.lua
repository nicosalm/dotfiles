return {
    'dmtrKovalenko/fff.nvim',
    build = 'cargo build --release',
    opts = { -- (optional)
        prompt = ' 🐉 ',
        debug = {
            enabled = false,     -- we expect your collaboration at least during the beta
            show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
        },
    },
    -- No need to lazy-load with lazy.nvim.
    -- This plugin initializes itself lazily.
    lazy = false,
    keys = {
        {
            '<leader>pf', -- find files in current dir
            function() require('fff').find_files() end,
            desc = 'Find files in current directory',
        },
        {
            '<C-p>', -- find files in git root
            function() require('fff').find_in_git_root() end,
            desc = 'Find git files',
        },
    }
}
