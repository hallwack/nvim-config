return {
  "adalessa/laravel.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "tpope/vim-dotenv",
    "MunifTanjim/nui.nvim",
  },
  cmd = { "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
  keys = {
    { "<leader>la", ":Laravel artisan<cr>" },
    { "<leader>lr", ":Laravel routes<cr>" },
    {
      "<leader>lt",
      function()
        require("laravel.tinker").send_to_tinker()
      end,
      mode = "v",
      desc = "Laravel Application Routes",
    },
  },
  event = { "VeryLazy" },
  config = function()
    local ok_laravel, laravel = pcall(require, 'laravel')
    local ok_telescope, telescope = pcall(require, 'telescope')
    if not (ok_laravel and ok_telescope) then return end

    laravel.setup({
      lsp_server = "inteliphense",
      split = {
        size = "60%"
      },
      environment = {
        resolver = require "laravel.environment.resolver" (true, true, "docker-compose"),
        environments = {
          ["local"] = require("laravel.environment.native").setup(),
          ["sail"] = require("laravel.environment.sail").setup(),
          ["docker-compose"] = require("laravel.environment.docker_compose").setup(),
        },
      },
    })
    telescope.load_extension("laravel")
  end,
}
