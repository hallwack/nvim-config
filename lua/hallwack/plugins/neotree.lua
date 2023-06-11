return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local ok_neotree, neotree = pcall(require, "neo-tree")

    if not ok_neotree then return end

    neotree.setup({
      window = {
        position = "right",
      }
    })
  end
}
