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
					"html", "emmet_ls", "cssls", "tailwindcss",
				}
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local lspconfig = require("lspconfig")
			local util = require("vim.lsp.util")

			local function lsp_formatting(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					local params = util.make_formatting_params({})
					vim.api.nvim_create_autocmd("BufWritePre", {
						callback = function()
							-- client.request('textDocument/formatting', params, nil, bufnr)
							vim.lsp.buf.format { async = false, id = params.client_id }
						end,
					})
				end
			end

			-- lspconfig.lua_ls.setup({
			-- 	capabilities = capabilities,
			-- 	on_attach = function(client, bufnr)
			-- 		lsp_formatting(client, bufnr)
			-- 	end,
			-- })

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
						on_attach = function(client, bufnr)
							lsp_formatting(client, bufnr)
						end,
					})
				end
			})

			local function ts_organize_imports()
				local params = {
					command = "_typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(0) },
					title = "",
				}
				vim.lsp.buf.execute_command(params)
			end

			local function ts_formatting(client, bufnr)
				local jsonOutput = vim.api.nvim_exec("!npm list --depth=0 --json", true)

				if string.find(jsonOutput, "prettier") ~= nil then
					vim.api.nvim_create_autocmd("BufWritePre", {
						callback = function()
							ts_organize_imports()
						end,
					})
					vim.api.nvim_create_autocmd("BufWritePost", {
						callback = function()
							vim.cmd [[ silent ! npx prettier % --write]]
						end
					})
				elseif client.supports_method("textDocument/formatting") then
					local params = util.make_formatting_params({})
					vim.api.nvim_create_autocmd("BufWritePre", {
						callback = function()
							ts_organize_imports()
							-- client.request('textDocument/formatting', params, nil, bufnr)
							vim.lsp.buf.format { async = false, id = params.client_id }
						end,
					})
				end
			end

			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					vim.keymap.set('n', '<leader>gpf', ":! npx prettier % --write <CR>",
						{ desc = 'Run prettier on current file' })
					vim.keymap.set('n', '<leader>gpp', ":! npx prettier . --write <CR>",
						{ desc = 'Run prettier in project' })

					ts_formatting(client, bufnr)
				end,
				commands = {
					OrganizeImports = {
						ts_organize_imports,
						description = "Organize Imports",
					},
				},

			})
		end
	}
}
