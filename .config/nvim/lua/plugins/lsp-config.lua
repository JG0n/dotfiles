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

			vim.lsp.config("*", {
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					lsp_formatting(client, bufnr)
				end
			})

			vim.lsp.config["csharp_ls"] = {
				capabilities = capabilities,
				on_attach = function()
					vim.api.nvim_create_autocmd("BufWritePre", {
						callback = function()
							-- client.request('textDocument/formatting', params, nil, bufnr)
							vim.lsp.buf.format { async = false }
						end,
					})
				end
			}
			require("csharpls_extended").buf_read_cmd_bind()


			vim.lsp.config["lua_ls"] = {
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
			}

			vim.lsp.config["ts_ls"] = {
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
			}

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
					"basedpyright",
					"ts_ls", "eslint",
					"hyprls",
					"html", "emmet_ls", "cssls", "tailwindcss",
					"csharp_ls",
				},
				automatic_enable = true
			})

			vim.lsp.enable('gdscript')
		end
	}
}
