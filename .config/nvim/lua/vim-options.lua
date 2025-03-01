vim.cmd("set noexpandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd('set tabline=%!MyTabLine()')
vim.cmd([[
    function MyTabLine()
        let s = ''
        for i in range(tabpagenr('$'))
            " select the highlighting
            if i + 1 == tabpagenr()
                let s ..= '%#TabLineSel#'
            else
                let s ..= '%#TabLine#'
            endif
            " set the tab page number (for mouse clicks)
            let s ..= '%' .. (i + 1) .. 'T'
            " the label is made by MyTabLabel()
            let s ..= ' %{MyTabLabel(' .. (i + 1) .. ')} '
        endfor
        " after the last tab fill with TabLineFill and reset tab page nr
        let s ..= '%#TabLineFill#%T'
        " right-align the label to close the current tab page
        if tabpagenr('$') > 1
            let s ..= '%=%#TabLine#%999Xclose'
        endif
        return s
    endfunction
]])
vim.cmd([[
    function MyTabLabel(n)
        let buflist = tabpagebuflist(a:n)
        let winnr = tabpagewinnr(a:n)
        let label = a:n .. ' ' .. fnamemodify(bufname(buflist[winnr - 1]), ':t')
        return label
    endfunction
]])

-- Sets
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.autoread = true

vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 20
vim.opt.foldopen = "all"

vim.opt.helpheight = 9999
-- Keymaps

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.api.nvim_set_keymap('n', '<esc>', ':noh<return>', { noremap = true })

-- Copy/Paste
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true })

vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', { noremap = true })

-- Neotree
-- vim.keymap.set('n', '<leader>h', ':Neotree filesystem reveal left<CR>', {})
-- vim.keymap.set('n', '<leader>l', ':Neotree filesystem reveal right<CR>', {})
vim.keymap.set('n', '<leader>mf', ':Neotree filesystem reveal float<CR>', {})
vim.keymap.set('n', '<leader>mb', ':Neotree buffers reveal float<CR>', {})

-- Telescope
vim.keymap.set('n', '<leader>ff', ":Telescope find_files<CR>", { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fa', ':lua require"telescope.builtin".find_files({ hidden = true })<CR>',
	{ desc = 'Telescope all find files' })
vim.keymap.set('n', '<leader>fg', ":Telescope live_grep<CR>", { desc = 'Telescope live grep' })

-- Lsp
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>df', vim.diagnostic.open_float, { desc = 'Diagnostic open float' })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = 'Diagnostic go to next' })
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = 'Diagnostic go to prev' })
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = 'Diagnostic set loclist' })


-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Lsp hover over info' })
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Lsp declaration' })
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Lsp definition' })
		vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, { desc = 'Lsp type definition' })
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, { desc = 'Lsp Code Action' })
		vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'Lsp buffer formatting', buffer = ev.buf })
		vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'Lsp rename' })
		vim.keymap.set('n', '<leader>lo', ":OrganizeImports<CR>", { desc = 'Lsp organize imports' })
	end
})

-- tabs
vim.keymap.set('n', '<leader>tt', ":tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set('n', '<leader>tq', ":tabclose<CR>", { desc = "Open new tab" })
vim.keymap.set('n', '<leader>tn', ":tabnext<CR>", { desc = "Open new tab" })
vim.keymap.set('n', '<C-l>', ":tabnext<CR>", { desc = "Open new tab" })
vim.keymap.set('n', '<leader>tp', ":tabprevious<CR>", { desc = "Open new tab" })
vim.keymap.set('n', '<C-h>', ":tabprevious<CR>", { desc = "Open new tab" })
