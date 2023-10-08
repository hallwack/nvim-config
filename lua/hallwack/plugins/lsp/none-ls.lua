return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufReadPre" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd.with({
          condition = function(utils)
            return utils.root_has_file({ ".prettierrc" })
          end,
        }),
        null_ls.builtins.formatting.eslint_d.with({
          prefer_local = "node_modules/.bin",
          condition = function(utils)
            return utils.root_has_file({ ".eslintrc.js" })
          end,
        }),
        null_ls.builtins.formatting.blade_formatter,
      },
    })
  end
}
