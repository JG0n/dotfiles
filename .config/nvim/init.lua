-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require('vim-options')

local spec = {
	-- import your plugins
	{
		import = "plugins",
	},
}

-- Configure any other settings here. See the documentation for more details.
-- colorscheme that will be used when installing plugins.
local install = { colorscheme = { "catppuccin" } }

-- automatically check for plugin updates
local checker = { enabled = true, notify = false }

-- Setup lazy.nvim
require("lazy").setup({
	spec = spec,
	install = install,
	checker = checker,
	change_detection = {
		enabled = false,
		notify = false,
	},
})

-- Check if a godot project file exists in directory and if so listen on
-- server
local gdproject = io.open(vim.fn.getcwd() .. '/project.godot', 'r')
if gdproject then
	io.close(gdproject)
	vim.fn.serverstart './godothost'
end
