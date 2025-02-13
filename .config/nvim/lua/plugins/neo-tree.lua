return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        require("neo-tree").setup({
            window = {
                mappings = {
                    ['l'] = 'open',
                    ['h'] = 'close_node',
                    ['L'] = 'open_nofocus',
                    ['t'] = 'open_tab',
                }
            },
            commands = {
                open_nofocus = function (state)
                    require("neo-tree.sources.filesystem.commands").open(state)
                    vim.schedule(function ()
                        vim.cmd([[Neotree close]])
                    end)
                end,
                open_tab = function (state)
                    local node = state.tree:get_node()
                    local path = node.path
                    local modify = vim.fn.fnamemodify

                    vim.api.nvim_input(":tabnew " .. modify(path, ':.') .. "<CR>")
                end
            },
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            }
        })
    end
}
