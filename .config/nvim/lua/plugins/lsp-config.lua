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
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local lspconfig = require("lspconfig")
			local util = require("vim.lsp.util")

			local function lsp_formatting(client, bufnr)
				local params = util.make_formatting_params({})
				vim.api.nvim_create_autocmd("BufWritePre", {
					callback = function()
						if client.supports_method("textDocument/formatting") then
							client.request('textDocument/formatting', params, nil, bufnr)
						end
					end,
				})
			end

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					lsp_formatting(client, bufnr)
				end,
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					lsp_formatting(client, bufnr)
				end,
				-- cmd = {"gopls"},
				-- filetype = {"go", "gomod", "gowork", "gotmpl"},
				-- root_dir = root_pattern("go.work", "go.mod", ".git"),
			})

			lspconfig.basedpyright.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					lsp_formatting(client, bufnr)
				end,
			})

			local function ts_organize_imports()
				local params = {
					command = "_typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(0) },
					title = "",
				}
				vim.lsp.buf.execute_command(params)
			end

			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					lsp_formatting(client, bufnr)
				end,
				commands = {
					OrganizeImports = {
						ts_organize_imports,
						description = "Organize Imports",
					},
				},

			})

			lspconfig.eslint.setup({
				capabilities = capabilities,
			})

			lspconfig.hyprls.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					lsp_formatting(client, bufnr)
				end,
			})

			lspconfig.gdscript.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					lsp_formatting(client, bufnr)
				end,
			})

			lspconfig.csharp_ls.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					lsp_formatting(client, bufnr)
				end,
			})

			lspconfig.html.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					lsp_formatting(client, bufnr)
				end,
			})

			lspconfig.emmet_ls.setup({
				capabilities = capabilities
			})

			lspconfig.cssls.setup {
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					lsp_formatting(client, bufnr)
				end,
			}

			lspconfig.tailwindcss.setup({
				capabilities = capabilities
			})
		end
	}
}
