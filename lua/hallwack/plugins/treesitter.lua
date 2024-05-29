return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    {
      "windwp/nvim-ts-autotag",
      config = function()
        require('nvim-ts-autotag').setup({
          opts = {
            enable_close = true,          -- Auto close tags
            enable_rename = true,         -- Auto rename pairs of tags
            enable_close_on_slash = false -- Auto close on trailing </
          },
        })
      end
    },
    {
      "nvim-treesitter/nvim-treesitter-context",
    },
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      ensure_installed = {
        "cpp",
        "python",
        "lua",
        "java",
        "javascript",
        "typescript",
        "html",
        "css",
        "php",
        "tsx",
        "jsdoc",
        "json",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "dockerfile",
        "svelte"
      },
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      autotag = {
        enable = true,
        enable_close_on_slash = false,
      },
    })
  end,
}
