return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = {
                "lua",
                "go",
                "hyprlang",
                "bash",
                "gdscript", "godot_resource", "gdshader",
                "c_sharp",
                "comment"
            },
            highlight = { enable = true },
            indent = { enable = true },
        })
        vim.filetype.add({
            pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
        })
    end
}
