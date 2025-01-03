return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = {"lua", "go", "hyprlang", "bash", "gdscript", "c_sharp"},
            highlight = { enable = true },
            indent = { enable = true },
        })
        vim.filetype.add({
            pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
        })
    end
}
