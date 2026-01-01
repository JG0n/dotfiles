return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/nvim-cmp',
			'saadparwaiz1/cmp_luasnip',
			'rafamadriz/friendly-snippets',
			'L3MON4D3/LuaSnip',
		},
		config = function()
			local cmp = require('cmp')
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({
									select = true,
								})
							end
						else
							fallback()
						end
					end),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' }, -- For luasnip users.
				}, {
					{ name = 'buffer' },
				}),
				-- sorting = {
				-- 	comparators = {
				-- 		-- compare.score_offset, -- not good at all
				-- 		cmp.config.compare.exact,
				-- 		-- cmp.config.compare.kind,
				-- 		cmp.config.compare.locality,
				-- 		cmp.config.compare.recently_used,
				-- 		cmp.config.compare.length,
				-- 		cmp.config.compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
				-- 		cmp.config.compare.offset,
				-- 		cmp.config.compare.order,
				-- 		-- cmp.config.compare.scopes, -- what?
				-- 		-- cmp.config.compare.sort_text,
				-- 	},
				-- }
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				}),
				matching = { disallow_symbol_nonprefix_matching = false }
			})
		end
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			local luasnip = require("luasnip")

			-- C#
			luasnip.filetype_extend("cs", { "csharpdoc" })

			-- JS
			luasnip.filetype_extend("typescript", { "tsdoc" })
			-- luasnip.filetype_extend("ts", { "next-ts" })
			-- luasnip.filetype_extend("ts", { "react-ts" })

			-- TS
			luasnip.filetype_extend("javascript", { "jsdoc" })
		end
	}
}
