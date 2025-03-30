return {
  --[[ {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      local cat = require("catppuccin")

      cat.setup({
        flavour = "mocha",
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true,
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
        },
      })

      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "rockyzhang24/arctic.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      vim.cmd("colorscheme arctic")
    end,
  },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    config = function()
      vim.g.nightflyTransparent = true
      vim.cmd("colorscheme nightfly")
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
  {
    "askfiy/visual_studio_code",
    priority = 100,
    config = function()
      require("visual_studio_code").setup({
        transparent = true,
      })
      vim.cmd("colorscheme visual_studio_code")
    end,
  },
  {
    "Mofiqul/vscode.nvim",
    config = function()
      require("vscode").setup({})
      require("vscode").load()
    end,
  }, ]]
  --[[ {
    "RRethy/nvim-base16",
    config = function()
      require("base16-colorscheme").with_config({
        telescope = false,
      })
      vim.cmd("colorscheme base16-black-metal-bathory")
    end,
  }, ]]
  --[[ {
    "datsfilipe/vesper.nvim",
    config = function()
      require("vesper").setup({
        transparent = true,
        italics = {
          comments = false,  -- Boolean: Italicizes comments
          keywords = false,  -- Boolean: Italicizes keywords
          functions = false, -- Boolean: Italicizes functions
          strings = false,   -- Boolean: Italicizes strings
          variables = false, -- Boolean: Italicizes variables
        },
      })

      vim.cmd("colorscheme vesper")
    end
  }, ]]
  --[[ {
    "bakageddy/alduin.nvim",
    priority = 1000,
    config = function()
      require("alduin").setup({
        terminal_colors = true, -- add neovim terminal colors
        inverse = true,
        palette_overrides = {},
        overrides = {},
      })

      vim.cmd("colorscheme alduin")
    end
  }, ]]
  --[[ {
    "judaew/ronny.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("ronny")
      require("ronny").setup()
    end
  }, ]]
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('nordic').load({
        transparent = {
          bg = true,
          float = true
        },
        italic_comments = false,
      })
    end
  },
}
