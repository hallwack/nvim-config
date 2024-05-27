return {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  opts  = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = { show_start = true, show_end = true },
  },
  main  = "ibl",
}
