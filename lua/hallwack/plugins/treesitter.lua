return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			ensure_installed = { "cpp", "python", "lua", "java", "javascript", "typescript", "html", "css" },
			highlight = {
				enable = true,
			},
			indent = { enable = true },
			autotag = {
				enable = true,
				enable_close_on_slash = false
			},
		})
	end,
}
