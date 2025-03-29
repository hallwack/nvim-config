return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  event = { "BufReadPre", "BufNewFile" },
  build = ":MasonUpdate",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    {
      "mrcjkb/rustaceanvim",
      version = "3",
      ft = { "rs" },
      config = function()
        vim.g.rustaceanvim = {
          server = {
            settings = {
              ["rust-analyzer"] = {
                diagnostics = {
                  disabled = { "unresolved-proc-macro" },
                },
              },
            },
          },
        }
      end,
    },
  },
  config = function()
    local mason = require("mason")
    local masonlsp = require("mason-lspconfig")
    local lspconfig = require("lspconfig")

    local default_setup = function(server)
      lspconfig[server].setup({})
    end

    mason.setup({
      ui = {
        border = "rounded",
      },
    })

    masonlsp.setup({
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "denols",
        "tailwindcss",
        "prismals",
        "html",
        "cssls",
        "svelte",
        "astro",
        "jsonls",
        "quick_lint_js",
        "intelephense",
      },
      handlers = {
        default_setup,
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
                    { "cn\\(([^)]*)\\)",   "[\"'`]([^\"'`]*).*?[\"'`]" },
                  },
                },
              },
            },
          })
        end,
        ts_ls = function()
          lspconfig.ts_ls.setup({
            single_file_support = false,
            root_dir = lspconfig.util.root_pattern({ "package.json" })
          })
        end,
        denols = function()
          lspconfig.denols.setup({
            single_file_support = false,
            root_dir = lspconfig.util.root_pattern({ "deno.json", "deno.jsonc" })
          })
        end,
        quick_lint_js = function()
          lspconfig.quick_lint_js.setup({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
          })
        end
      },
    })
  end,
}
