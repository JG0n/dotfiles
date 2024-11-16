return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "gopls",
                    "basedpyright",
                    "ts_ls",
                    "hyprls"
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                capabilities = capabilities
            })
            lspconfig.gopls.setup({
                capabilities = capabilities,
                -- cmd = {"gopls"},
                -- filetype = {"go", "gomod", "gowork", "gotmpl"},
                -- root_dir = root_pattern("go.work", "go.mod", ".git"),
            })
            lspconfig.basedpyright.setup({
                capabilities = capabilities,
            })
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.hyprls.setup({
                capabilities = capabilities,
            })


            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, {desc = 'Diagnostic open float' })
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {desc = 'Diagnostic go to next' })
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {desc = 'Diagnostic go to prev' })
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, {desc = 'Diagnostic set loclist' })


            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function (ev)

                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc = 'Lsp hover over info', buffer = ev.buf})
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {desc = 'Lsp declaration', buffer = ev.buf})
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {desc = 'Lsp definition', buffer = ev.buf})
                    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {desc = 'Lsp Code Action', buffer = ev.buf})
                end
            })
        end
    }
}
