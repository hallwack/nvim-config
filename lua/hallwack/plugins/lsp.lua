return {
	"neovim/nvim-lspconfig",
	cmd = "LspInfo",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"jose-elias-alvarez/null-ls.nvim",
		"onsails/lspkind-nvim",
		{ "glepnir/lspsaga.nvim", event = "LspAttach" },
		"jose-elias-alvarez/typescript.nvim",
		"simrat39/rust-tools.nvim",
	},
	config = function()
		local ok_lspzero, lsp = pcall(require, "lsp-zero")
		local ok_lsp, lspconfig = pcall(require, "lspconfig")
		local ok_mason, mason = pcall(require, "mason")
		local ok_mason_lsp, masonlsp = pcall(require, "mason-lspconfig")
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
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
							[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
						},
						maxPreload = 100000,
						preloadFileSize = 10000,
					},
				},
			},
		})
		lspconfig.tailwindcss.setup({
			settings = {
				tailwindCSS = {
					experimental = {
						classRegex = {
							{ "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
							{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
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
				null_ls.builtins.formatting.prettierd.with({
					condition = function(utils)
						return utils.root_has_file({ ".prettierrc" })
					end,
				}),
				null_ls.builtins.formatting.eslint_d.with({
					prefer_local = "node_modules/.bin",
					condition = function(utils)
						return utils.root_has_file({ ".eslintrc.js" })
					end,
				}),
				null_ls.builtins.formatting.blade_formatter,
			},
		})
	end,
}
