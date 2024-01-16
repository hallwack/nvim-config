return {
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	},
	{
		"echasnovski/mini.hipatterns",
		event = "BufReadPre",
		version = "*",
		config = function()
			local hipatterns = require("mini.hipatterns")

			local short_hex_color = function(_, match)
				local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
				local hex = string.format("#%s%s%s%s%s%s", r, r, g, g, b, b)
				return MiniHipatterns.compute_hex_color_group(hex, "bg")
			end

			hipatterns.setup({
				highlighters = {
					hex_color = hipatterns.gen_highlighter.hex_color(),
					short_hex_color = { pattern = "#%x%x%x%f[%X]", group = short_hex_color },
				},
			})
		end,
	},
}
