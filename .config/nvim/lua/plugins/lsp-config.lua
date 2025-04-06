return {
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"prettier/vim-prettier",
			"Decodetalkers/csharpls-extended-lsp.nvim",
		},
		config = function()
			require("mason").setup()

			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local lspconfig = require("lspconfig")
			local util = require("vim.lsp.util")

			-- General LSP Config
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

			local function lsp_fold(client)
				if client:supports_method('textDocument/foldingRange') then
					local win = vim.api.nvim_get_current_win()
					vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
				end
			end

			-- TSServer Specific

			local function ts_organize_imports()
				local params = {
					command = "_typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(0) },
					title = "",
				}
				return vim.lsp.buf.execute_command(params)
			end

			local function ts_formatting(client, bufnr)
				local jsonOutput = vim.api.nvim_exec("!npm list --depth=0 --json", true)

				if string.find(jsonOutput, "prettier") ~= nil then
					vim.api.nvim_create_autocmd("BufWritePre", {
						callback = function()
							-- ts_organize_imports()
							vim.cmd(":PrettierAsync")
						end,
					})
				elseif client.supports_method("textDocument/formatting") then
					local params = util.make_formatting_params({})
					vim.api.nvim_create_autocmd("BufWritePre", {
						callback = function()
							ts_organize_imports()
							vim.lsp.buf.format { async = false, id = params.client_id }
						end,
					})
				end
			end

			local handlers = {
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
						on_attach = function(client, bufnr)
							lsp_formatting(client, bufnr)
						end,
					})
				end,
				["ts_ls"] = function()
					lspconfig.ts_ls.setup({
						capabilities = capabilities,
						on_attach = function(client, bufnr)
							-- vim.keymap.set('n', '<leader>gpf', ":! npx prettier % --write <CR>",
							-- 	{ desc = 'Run prettier on current file' })
							vim.keymap.set('n', '<leader>gpp', ":! npx prettier . --write <CR>",
								{ desc = 'Run prettier in project' })
							vim.keymap.set('n', '<leader>gpf', ":Prettier<CR>",
								{ desc = 'Run prettier on current file' })

							ts_formatting(client, bufnr)
						end,
						commands = {
							OrganizeImports = {
								ts_organize_imports,
								description = "Organize Imports",
							},
						},
					})
				end,
				['lua_ls'] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						on_attach = function(client, bufnr)
							lsp_formatting(client, bufnr)
						end,
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
								},
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
								},
								telemetry = {
									enable = false,
								},
							}
						},
					})
				end,
			}

			lspconfig.csharp_ls.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					local params = util.make_formatting_params({})
					vim.api.nvim_create_autocmd("BufWritePre", {
						callback = function()
							-- client.request('textDocument/formatting', params, nil, bufnr)
							vim.lsp.buf.format { async = false, id = params.client_id }
						end,
					})
				end,
				handlers = {
					["textDocument/definition"] = require('csharpls_extended').handler,
					["textDocument/typeDefinition"] = require('csharpls_extended').handler,
				},
			})

			require("mason-lspconfig").setup({
				handlers = handlers,
				automatic_installation = false,
				ensure_installed = {
					"lua_ls",
					"gopls",
					"basedpyright",
					"ts_ls", "eslint",
					"hyprls",
					-- "csharp_ls",
					"html", "emmet_ls", "cssls", "tailwindcss",
					"omnisharp",
				}
			})
		end
	}
}
