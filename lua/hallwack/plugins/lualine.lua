return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = function()
		return {
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "NvimTree", "Outline" },
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 2 } },
				lualine_b = {
					{
						"filename",
						file_status = true,
						path = 1,
					},
				},
				lualine_c = {
					{
						"fileformat",
						symbols = {
							unix = "",
							dos = "",
							mac = "",
						},
					},
				},
				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						colored = true,
						update_in_insert = true,
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
					},
					{
						function()
							local buf_clients_name = {}
							local msg = "No Active Lsp"
							local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
							local clients = vim.lsp.get_active_clients()

							if next(clients) == nil then
								return msg
							end

							for _, client in ipairs(clients) do
								local filetypes = client.config.filetypes
								if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
									table.insert(buf_clients_name, client.name)
								end
							end

							if buf_clients_name then
								return "[" .. table.concat(buf_clients_name, ", ") .. "]"
							else
								return msg
							end
						end,
						icon = " LSP:",
						color = { fg = "#e57474", gui = "bold" },
					},
					{ "filetype", colored = true },
				},
				lualine_y = { "progress" },
				lualine_z = { { "location", separator = { left = "", right = "" }, left_padding = 0 } },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						"filename",
						file_status = true,
						path = 1,
					},
				},
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
		}
	end,
}
