return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	dependencies = {
		"neovim/nvim-lspconfig",
		{
			"williamboman/mason.nvim",
			build = function()
				pcall(vim.cmd, "MasonUpdate")
			end,
		},
		"williamboman/mason-lspconfig.nvim",
		"jose-elias-alvarez/null-ls.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind-nvim",
		{ "glepnir/lspsaga.nvim", event = "LspAttach" },
		"jose-elias-alvarez/typescript.nvim",
		"simrat39/rust-tools.nvim",
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		{
			"dsznajder/vscode-es7-javascript-react-snippets",
			build = "yarn install --frozen-lockfile && yarn compile",
		},
	},
	config = function()
		local ok_lspzero, lspzero = pcall(require, "lsp-zero")
		local ok_lsp, lspconfig = pcall(require, "lspconfig")
		local ok_mason, mason = pcall(require, "mason")
		local ok_mason_lsp, masonlsp = pcall(require, "mason-lspconfig")
		local ok_cmp, cmp = pcall(require, "cmp")
		local ok_lspkind, lspkind = pcall(require, "lspkind")
		local ok_luasnip, luasnip = pcall(require, "luasnip")
		local ok_null_ls, null_ls = pcall(require, "null-ls")
		local ok_lspsaga, lspsaga = pcall(require, "lspsaga")
		local ok_ts, ts = pcall(require, "typescript")
		local ok_rust_tools, rust_tools = pcall(require, "rust-tools")

		if
				not (
					ok_lspzero
					and ok_lsp
					and ok_mason
					and ok_mason_lsp
					and ok_cmp
					and ok_lspkind
					and ok_luasnip
					and ok_null_ls
					and ok_lspsaga
					and ok_ts
					and ok_rust_tools
				)
		then
			return
		end

		mason.setup({
			ui = {
				border = "rounded",
			},
		})
		masonlsp.setup({
			ensure_installed = { "lua_ls", "tsserver", "tailwindcss", "prismals", "html", "cssls" },
		})

		local lsp = lspzero.preset({})
		lspsaga.setup({
			ui = {
				theme = "round",
				border = "rounded",
				code_action = "💡",
				colors = {
					normal_bg = "#000000",
				},
			},
			preview = {
				lines_above = 0,
				lines_below = 10,
			},
			scroll_preview = {
				scroll_down = "<C-f>",
				scroll_up = "<C-b>",
			},
			finder = {
				max_height = 0.5,
				min_width = 30,
				force_max_height = false,
				keys = {
					jump_to = "p",
					expand_or_jump = "o",
					edit = { "o", "<CR>" },
					vsplit = "s",
					split = "i",
					tabe = "t",
					quit = { "q", "<ESC>" },
					close_in_preview = "<ESC>",
				},
			},
			code_action = {
				num_shortcut = true,
				keys = {
					quit = "q",
					exec = "<CR>",
				},
			},
		})

		lsp.on_attach(function(client, bufnr)
			local function buf_set_keymap(...)
				vim.api.nvim_buf_set_keymap(bufnr, ...)
			end

			lsp.default_keymaps({ buffer = bufnr, omit = { "<F3>", "<F4>", "<F2>", "[d", "]d" } })

			buf_set_keymap(
				"n",
				"<leader>fr",
				"<Cmd>lua vim.lsp.buf.format({ async = true })<CR>",
				{ noremap = true, silent = true }
			)
			buf_set_keymap("n", "gh", "<Cmd>Lspsaga lsp_finder<CR>", { noremap = true, silent = true })
			buf_set_keymap("n", "<leader>ca", "<Cmd>Lspsaga code_action<CR>", { noremap = true, silent = true })
			buf_set_keymap("n", "<leader>rn", "<Cmd>Lspsaga rename<CR>", { noremap = true, silent = true })
			buf_set_keymap(
				"n",
				"<leader>cd",
				"<Cmd>Lspsaga show_line_diagnostics<CR>",
				{ noremap = true, silent = true }
			)
			buf_set_keymap(
				"n",
				"<leader>cr",
				"<Cmd>Lspsaga show_cursor_diagnostics<CR>",
				{ noremap = true, silent = true }
			)
			buf_set_keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { noremap = true, silent = true })
			buf_set_keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { noremap = true, silent = true })
		end)

		lsp.set_sign_icons({
			error = "✘",
			warn = "▲",
			hint = "⚑",
			info = " ",
		})

		lsp.skip_server_setup({ "tsserver" })
		lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
		lspconfig.tailwindcss.setup({
			settings = {
				tailwindCSS = {
					experimental = {
						classRegex = {
							{ "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
							{ "cva\\(([^)]*)\\)",  "[\"'`]([^\"'`]*).*?[\"'`]" },
						},
					},
				},
			},
		})

		lsp.setup()
		ts.setup({})
		rust_tools.setup({})

		null_ls.setup({
			sources = {
				require("typescript.extensions.null-ls.code-actions"),
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.formatting.eslint_d,
				null_ls.builtins.formatting.blade_formatter,
			},
		})

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
