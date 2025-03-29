return {
  "neovim/nvim-lspconfig",
  cmd = { "LspInfo" },
  opts = {
    inlay_hints = {
      enabled = true
    }
  },
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "glepnir/lspsaga.nvim", event = "LspAttach" },
    {
      'dmmulroy/ts-error-translator.nvim',
      config = function()
        require('ts-error-translator').setup()

        vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
          require("ts-error-translator").translate_diagnostics(err, result, ctx, config)
          vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
        end
      end
    }
  },
  config = function()
    local lspsaga = require("lspsaga")

    local signs = {
      Error = "✘",
      Warn = "▲",
      Hint = "⚑",
      Info = " ",
    }

    vim.diagnostic.config({
      virtual_text = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = signs.Error,
          [vim.diagnostic.severity.WARN] = signs.Warn,
          [vim.diagnostic.severity.INFO] = signs.Info,
          [vim.diagnostic.severity.HINT] = signs.Hint,
        }
      }
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

    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP Actions",
      callback = function(event)
        local keymap = vim.keymap.set
        local function default_options(description)
          return { noremap = true, silent = true, desc = description }
        end

        keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", default_options("For LSP hover documentation"))
        --[[ keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>",
          default_options("For LSP definitions")) ]]
        keymap("n", "gd", "<Cmd>Lspsaga goto_definition<CR>", default_options("For LSP definitions"))
        keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", default_options("For LSP declaration"))
        keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", default_options("For LSP implementation"))
        keymap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", default_options("For LSP type definition"))
        keymap("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>",
          default_options("For LSP references"))
        keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", default_options("For LSP signature help"))

        keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", default_options("For LSP diagnostics"))
        --[[ keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts) ]]
        --[[ keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts) ]]

        --[[ keymap("n", "<leader>fr", "<Cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts) ]]
        keymap("n", "gh", "<Cmd>Lspsaga finder<CR>",
          default_options("For LSP finder (w/ references, implementations, and definitions)"))
        keymap("n", "<leader>ca", "<Cmd>Lspsaga code_action<CR>", default_options("For LSP code actions"))
        keymap("n", "<leader>rn", "<Cmd>Lspsaga rename<CR>", default_options("For LSP rename variable"))
        keymap("n", "<leader>cd", "<Cmd>Lspsaga show_line_diagnostics<CR>",
          default_options("For LSP show diagnostics (per line)"))
        keymap("n", "<leader>cr", "<Cmd>Lspsaga show_cursor_diagnostics<CR>",
          default_options("For LSP show diagnostics (per cursor)"))
        keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", default_options("For LSP show next diagnostics"))
        keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", default_options("For LSP show previous diagnostics"))
        keymap("n", "<leader>ol", "<cmd>Lspsaga outline<CR>", default_options("For LSP show outline"))
        keymap("n", "<A-t>", "<cmd>Lspsaga term_toggle<CR>", default_options("For showing terminal"))
      end,
    })
  end,
}
