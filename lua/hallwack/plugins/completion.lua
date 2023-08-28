return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			{
				"dsznajder/vscode-es7-javascript-react-snippets",
				build = "yarn install --frozen-lockfile && yarn compile",
			},
			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function()
					local ok_autopairs, autopairs = pcall(require, "nvim-autopairs")
					local ok_cmp, cmp = pcall(require, "cmp")

					if not (ok_autopairs and ok_cmp) then
						return
					end

					autopairs.setup({
						check_ts = true,
						ts_config = {
							lua = { "string", "source" },
							javascript = { "string", "template_string" },
						},
						fast_wrap = {
							map = "<M-e>",
							chars = { "{", "[", "(", '"', "'" },
							pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
							offset = 0, -- Offset from pattern match
							end_key = "$",
							keys = "qwertyuiopzxcvbnmasdfghjkl",
							check_comma = true,
							highlight = "PmenuSel",
							highlight_grey = "LineNr",
						},
					})

					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
				end,
			},
		},
	},
	config = function()
		local ok_cmp, cmp = pcall(require, "cmp")
		local ok_lspkind, lspkind = pcall(require, "lspkind")
		local ok_luasnip, luasnip = pcall(require, "luasnip")

		if not (ok_cmp and ok_lspkind and ok_luasnip) then
			return
		end

		require("lsp-zero.cmp").extend()

		require("luasnip/loaders/from_vscode").lazy_load()

		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-s>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-d>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expandable() then
						luasnip.expand()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
				{ name = "path" },
			}),
			formatting = {
				format = lspkind.cmp_format({
					with_text = true,
					maxwidth = 100,
					-- menu = ({
					--   buffer = "[Buffer]",
					--   nvim_lsp = "[LSP]",
					--   luasnip = "[LuaSnip]",
					--   nvim_lua = "[Lua]",
					--   latex_symbols = "[Latex]",
					-- })
				}),
			},
			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			},
		})
	end,
}
