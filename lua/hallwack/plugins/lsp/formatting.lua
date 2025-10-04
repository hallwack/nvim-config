return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>fr",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			sql = { "sql-formatter" },
			yaml = { "yamlfmt" },

			javascript = { "prettierd" },
			typescript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },
			svelte = { "prettierd" },
			css = { "prettierd" },
			html = { "prettierd" },
			json = { "prettierd" },
			markdown = { "prettierd" },
			graphql = { "prettierd" },

			--[[ javascript = { "prettier" }, ]]
			--[[ typescript = { "prettier" }, ]]
			--[[ javascriptreact = { "prettier" }, ]]
			--[[ typescriptreact = { "prettier" }, ]]
			--[[ svelte = { "prettier" }, ]]
			--[[ css = { "prettier" }, ]]
			--[[ html = { "prettier" }, ]]
			--[[ json = { "prettier" }, ]]
			--[[ markdown = { "prettier" }, ]]
			--[[ graphql = { "prettier" }, ]]
		},

		-- Customize formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
		},
	},
}
