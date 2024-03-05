return {
  "neovim/nvim-lspconfig",
  cmd = { "LspInfo" },
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "glepnir/lspsaga.nvim", event = "LspAttach" },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local lspsaga = require("lspsaga")
    local lsp_defaults = lspconfig.util.default_config

    lsp_defaults.capabilities =
        vim.tbl_deep_extend("force", lsp_defaults.capabilities, cmp_nvim_lsp.default_capabilities())

    local signs = {
      Error = "✘",
      Warn = "▲",
      Hint = "⚑",
      Info = " ",
    }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

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
        local opts = { noremap = true, silent = true, buffer = event.buf }

        keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
        keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", opts)
        keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
        keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
        keymap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
        keymap("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
        keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)

        keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
        --[[ keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts) ]]
        --[[ keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts) ]]

        keymap("n", "<leader>fr", "<Cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
        keymap("n", "gh", "<Cmd>Lspsaga finder<CR>", opts)
        keymap("n", "<leader>ca", "<Cmd>Lspsaga code_action<CR>", opts)
        keymap("n", "<leader>rn", "<Cmd>Lspsaga rename<CR>", opts)
        keymap("n", "<leader>cd", "<Cmd>Lspsaga show_line_diagnostics<CR>", opts)
        keymap("n", "<leader>cr", "<Cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
        keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
        keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
        keymap("n", "<leader>ol", "<cmd>Lspsaga outline<CR>", opts)
        keymap("n", "<A-t>", "<cmd>Lspsaga term_toggle<CR>", opts)
      end,
    })
  end,
}
