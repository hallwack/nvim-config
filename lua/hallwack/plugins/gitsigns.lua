return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local ok_git, gitsigns = pcall(require, "gitsigns")
			if not ok_git then
				return
			end

			gitsigns.setup({})
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		event = "VeryLazy",
	},
}
