return {
    "dmtrKovalenko/fff.nvim",
    build = function()
        require("fff.download").download_or_build_binary()
    end,
    opts = {
        prompt = " > ",
    },
    keys = {
        {
            "<leader>pf",
            function() require("fff").find_files() end,
            desc = "find files in current directory",
        },
        {
            "<C-p>",
            function() require("fff").find_in_git_root() end,
            desc = "find git files",
        },
    },
}
