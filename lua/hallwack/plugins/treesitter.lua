return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
		{
			"nvim-treesitter/nvim-treesitter-context",
		},
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			ensure_installed = {
				"cpp",
				"python",
				"lua",
				"java",
				"javascript",
				"typescript",
				"html",
				"css",
				"php",
				"tsx",
				"jsdoc",
				"json",
				"vim",
				"vimdoc",
				"markdown",
				"markdown_inline",
				"dockerfile",
			},
			highlight = {
				enable = true,
			},
			indent = { enable = true },
			autotag = {
				enable = true,
				enable_close_on_slash = false,
			},
		})
	end,
}
