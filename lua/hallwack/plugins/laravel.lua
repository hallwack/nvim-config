return {
	"adalessa/laravel.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"tpope/vim-dotenv",
		"MunifTanjim/nui.nvim",
	},
	cmd = { "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
	keys = {
		{ "<leader>la", ":Laravel artisan<cr>" },
		{ "<leader>lr", ":Laravel routes<cr>" },
		{
			"<leader>lt",
			function()
				require("laravel.tinker").send_to_tinker()
			end,
			mode = "v",
			desc = "Laravel Application Routes",
		},
	},
	config = function()
		local laravel = require("laravel")
		local telescope = require("telescope")

		laravel.setup({
			lsp_server = "inteliphense",
			split = {
				size = "60%",
			},
		})
		telescope.load_extension("laravel")
	end,
}
