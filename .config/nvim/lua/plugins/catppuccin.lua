return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		mocha = {
			base = "#000000",
			mantle = "#000000",
			crust = "#000000",
		},
	},
	config = function()
		require("catppuccin").setup({
			color_overrides = {
				mocha = {
					base = "#11111b",
				},
			},
		})

		-- setup must be called before loading
		vim.cmd.colorscheme "catppuccin"
	end
}
