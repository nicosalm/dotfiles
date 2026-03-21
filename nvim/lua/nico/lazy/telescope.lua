return {
    "ibhagwan/fzf-lua",
    keys = {
        { "<leader>pws", function() require("fzf-lua").grep_cword() end },
        { "<leader>pWs", function() require("fzf-lua").grep_cWORD() end },
        { "<leader>ps",  function() require("fzf-lua").live_grep() end },
        { "<leader>vh",  function() require("fzf-lua").help_tags() end },
    },
    opts = {},
}
