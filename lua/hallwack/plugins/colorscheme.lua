return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			local ok_cat, cat = pcall(require, "catppuccin")
			if not ok_cat then
				return
			end

			cat.setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = {
					-- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = true, -- disables setting the background color.
				term_colors = true,
				no_italic = true,
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					neotree = true,
					telescope = true,
					notify = false,
					mini = false,
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})

			--[[ vim.cmd.colorscheme("catppuccin") ]]
		end,
	},
	{
		"rockyzhang24/arctic.nvim",
		dependencies = { "rktjmp/lush.nvim" },
		config = function()
			--[[ vim.cmd("colorscheme arctic") ]]
		end,
	},
	{
		"bluz71/vim-nightfly-colors",
		name = "nightfly",
		lazy = false,
		config = function()
			vim.g.nightflyTransparent = true
			--[[ vim.cmd("colorscheme nightfly") ]]
		end,
	},
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = false,
		config = function()
			vim.g.moonflyTransparent = true
			vim.cmd("colorscheme moonfly")
		end,
	},
}
