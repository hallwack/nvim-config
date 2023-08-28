return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	lazy = true,
	config = function()
		require("lsp-zero.settings").preset({})
	end,
}
