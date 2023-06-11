return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,
  dependencies = {
    'windwp/nvim-ts-autotag'
  },
  config = function()
    local status, treesitter = pcall(require, "nvim-treesitter.configs")
    if not status then return end

    treesitter.setup({
      ensure_installed = { "cpp", "python", "lua", "java", "javascript", "typescript", "html", "css", },
      highlight = {
        enable = true,
      },
      autotag = {
        enable = true
      }
    })
  end
}
