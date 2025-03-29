-- return {
--   "hrsh7th/nvim-cmp",
--   event = "InsertEnter",
--   dependencies = {
--     {
--       "L3MON4D3/LuaSnip",
--       "hrsh7th/nvim-cmp",
--       "hrsh7th/cmp-nvim-lua",
--       "hrsh7th/cmp-buffer",
--       "hrsh7th/cmp-path",
--       "saadparwaiz1/cmp_luasnip",
--       "rafamadriz/friendly-snippets",
--       "onsails/lspkind.nvim",
--       {
--         "dsznajder/vscode-es7-javascript-react-snippets",
--         build = "yarn install --frozen-lockfile && yarn compile",
--       },
--       {
--         "windwp/nvim-autopairs",
--         opts = {
--           fast_wrap = {},
--           disable_filetype = { "TelescopePrompt", "vim" },
--         },
--         config = function()
--           local autopairs = require("nvim-autopairs")
--           local cmp = require("cmp")

--           autopairs.setup({
--             check_ts = true,
--             ts_config = {
--               lua = { "string", "source" },
--               javascript = { "string", "template_string" },
--               svelte = { "string", "template_string" },
--             },
--             fast_wrap = {
--               map = "<M-e>",
--               chars = { "{", "[", "(", '"', "'" },
--               pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
--               offset = 0,
--               end_key = "$",
--               keys = "qwertyuiopzxcvbnmasdfghjkl",
--               check_comma = true,
--               highlight = "PmenuSel",
--               highlight_grey = "LineNr",
--             },
--           })

--           local cmp_autopairs = require("nvim-autopairs.completion.cmp")
--           cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
--         end,
--       },
--       {
--         "zbirenbaum/copilot-cmp",
--         config = function()
--           require("copilot_cmp").setup()
--         end
--       }
--     },
--   },
--   config = function()
--     local cmp = require("cmp")
--     local lspkind = require("lspkind")
--     local luasnip = require("luasnip")

--     require("luasnip/loaders/from_vscode").lazy_load()

--     local has_words_before = function()
--       unpack = unpack or table.unpack
--       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--     end

--     cmp.setup({
--       snippet = {
--         expand = function(args)
--           luasnip.lsp_expand(args.body)
--         end,
--       },
--       window = {
--         completion = cmp.config.window.bordered(),
--         documentation = cmp.config.window.bordered(),
--       },
--       mapping = cmp.mapping.preset.insert({
--         ["<C-k>"] = cmp.mapping.select_prev_item(),
--         ["<C-j>"] = cmp.mapping.select_next_item(),
--         ["<C-u>"] = cmp.mapping.scroll_docs(-4),
--         ["<C-d>"] = cmp.mapping.scroll_docs(4),
--         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--         ["<C-f>"] = cmp.mapping.scroll_docs(4),
--         ["<C-Space>"] = cmp.mapping.complete(),
--         ["<C-e>"] = cmp.mapping({
--           i = cmp.mapping.abort(),
--           c = cmp.mapping.close(),
--         }),
--         ["<CR>"] = cmp.mapping.confirm({ select = true }),
--         ["<Tab>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_next_item()
--           elseif luasnip.expandable() then
--             luasnip.expand()
--           elseif luasnip.expand_or_jumpable() then
--             luasnip.expand_or_jump()
--           elseif has_words_before() then
--             cmp.complete()
--           else
--             fallback()
--           end
--         end, {
--           "i",
--           "s",
--         }),
--         ["<S-Tab>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_prev_item()
--           elseif luasnip.jumpable(-1) then
--             luasnip.jump(-1)
--           else
--             fallback()
--           end
--         end, {
--           "i",
--           "s",
--         }),
--       }),
--       sources = cmp.config.sources({
--         { name = "copilot" },
--         { name = "nvim_lsp" },
--         { name = "nvim_lua" },
--         { name = "luasnip" },
--       }, {
--         { name = "buffer" },
--         { name = "path" },
--       }),
--       formatting = {
--         format = require("tailwindcss-colorizer-cmp").formatter,
--       },
--       confirm_opts = {
--         behavior = cmp.ConfirmBehavior.Replace,
--         select = false,
--       },
--     })
--   end,
-- }
return {
  'saghen/blink.cmp',

  dependencies = {
    'rafamadriz/friendly-snippets',
    'fang2hou/blink-copilot',
    {
      'windwp/nvim-autopairs',
      config = function()
        local npairs = require "nvim-autopairs"
        npairs.setup({
          map_cr = true,
          check_ts = true,
          ts_config = {
            lua = { "string", "source" },
            javascript = { "string", "template_string" },
            svelte = { "string", "template_string" },
          },
          fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'", "<" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0,
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
          },
        })
      end
    },
    {
      'L3MON4D3/LuaSnip', version = 'v2.*'
    },
    {
      "xzbdmw/colorful-menu.nvim",
      config = function()
        require("colorful-menu").setup({})
      end
    }
  },

  version = '1.*',

  opts = {
    signature = { enabled = true },
    keymap = {
      preset = 'default',
      ["<C-k>"] = { 'select_prev', 'fallback' },
      ["<C-j>"] = { 'select_next', 'fallback' },
      ["<C-g>"] = { 'show_signature', 'hide_signature', 'fallback' },
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<C-w>'] = { 'select_prev', 'fallback' },
      ['<C-s>'] = { 'select_next', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
    },

    snippets = { preset = 'luasnip' },

    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = {
      documentation = {
        auto_show = true
      },

      menu = {
        draw = {
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
          },
        }
      }
    },
    sources = {
      default = { 'copilot', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        }
      }
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" },
}
