return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  event = { "BufReadPre", "BufNewFile" },
  build = ":MasonUpdate",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    {
      "simrat39/rust-tools.nvim",
      ft = { "rs" }
    },
  },
  config = function()
    local mason = require("mason")
    local masonlsp = require("mason-lspconfig")
    local lspconfig = require("lspconfig")
    local rust_tools = require("rust-tools")

    local default_setup = function(server)
      lspconfig[server].setup({})
    end

    mason.setup({
      ui = {
        border = "rounded",
      },
    })

    masonlsp.setup({
      ensure_installed = { "lua_ls", "tsserver", "tailwindcss", "prismals", "html", "cssls" },
      handlers = {
        default_setup,
        -- tsserver = function()
        --   lspconfig.tsserver.setup({
        --     settings = {
        --       filetypes = {
        --         "typescript",
        --         "javascript",
        --         "javascriptreact",
        --         "typescriptreact",
        --         "typescript.tsx",
        --         "javascript.jsx",
        --       },
        --       cmd = { "typescript-language-server", "--stdio" },
        --     },
        --   })
        -- end,
        lua_ls = function()
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
                workspace = {
                  library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
                  },
                  maxPreload = 100000,
                  preloadFileSize = 10000,
                },
              },
            },
          })
        end,
        tailwindcss = function()
          lspconfig.tailwindcss.setup({
            settings = {
              tailwindCSS = {
                experimental = {
                  classRegex = {
                    { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                    { "cva\\(([^)]*)\\)",  "[\"'`]([^\"'`]*).*?[\"'`]" },
                  },
                },
              },
            },
          })
        end,
        rust_analyzer = function()
          rust_tools.setup({})
        end,
      }
    })
  end,
}
