return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufReadPre" },
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettierd.with({
					prefer_local = "node_modules/.bin",
				}),
				null_ls.builtins.diagnostics.eslint_d.with({
					prefer_local = "node_modules/.bin",
					condition = function(condition_utils)
						return condition_utils.root_has_file({ ".eslintrc.js", ".eslintrc.json" })
					end,
				}),
				null_ls.builtins.formatting.blade_formatter,
			},
		})
	end,
}
