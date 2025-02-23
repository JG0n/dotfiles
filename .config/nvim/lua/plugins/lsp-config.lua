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
					"ts_ls", "eslint",
					"hyprls",
					"csharp_ls",
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

			lspconfig.eslint.setup({
				capabilities = capabilities,
			})

			lspconfig.hyprls.setup({
				capabilities = capabilities,
			})

			lspconfig.gdscript.setup({
				capabilities = capabilities,
			})

			lspconfig.csharp_ls.setup({
				capabilities = capabilities,
			})
		end
	}
}
