vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Sets
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.autoread = true

-- Keymaps

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.api.nvim_set_keymap('n', '<esc>', ':noh<return>', {noremap = true})

-- Copy/Paste
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', {noremap = true})

vim.api.nvim_set_keymap('v', '<leader>y', '"+y', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', {noremap = true})

-- Neotree
-- vim.keymap.set('n', '<leader>h', ':Neotree filesystem reveal left<CR>', {})
-- vim.keymap.set('n', '<leader>l', ':Neotree filesystem reveal right<CR>', {})
vim.keymap.set('n', '<leader>l', ':Neotree filesystem reveal float<CR>', {})
vim.keymap.set('n', '<leader>b', ':Neotree buffers reveal float<CR>', {})

-- Telescope
vim.keymap.set('n', '<leader>ff', ":Telescope find_files<CR>", {desc = 'Telescope find files'})
vim.keymap.set('n', '<leader>fg', ":Telescope live_grep<CR>", { desc = 'Telescope live grep' })

-- Lsp
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
