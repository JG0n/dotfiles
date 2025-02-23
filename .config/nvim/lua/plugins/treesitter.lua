return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                ensure_installed = {
                    "lua", "luadoc", "luap",
                    "go",
                    "bash",
                    "python",
                    "typescript", "tsx", "javascript", "jsdoc",
                    "c_sharp",
                    "typescript", "tsx", "javascript", "jsdoc",
                    "gdscript", "godot_resource", "gdshader",
                    "xml", "yaml", "toml",
                    "json", "jsonc", "regex",
                    "vim", "vimdoc",
                    "hyprlang",
                },
                highlight = { enable = true },
                indent = { enable = true },
            })
            vim.filetype.add({
                pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
            })
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    }
}
