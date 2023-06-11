return {
  "goolord/alpha-nvim",
  config = function()
    local ok_alpha, alpha = pcall(require, "alpha")
    if not ok_alpha then return end

    alpha.setup(require("alpha.themes.startify").config)
  end,
}
