return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    return {
      options = {
        icons_enabled = true,
        theme = "auto",
        --[[ component_separators = { left = "", right = "" }, ]]
        component_separators = { left = "", right = "" },
        section_separators = {
          --[[ left = "", ]]
          left = " ",
          --[[ right = "", ]]
          right = " ",
        },
        disabled_filetypes = { "alpha", "NvimTree", "Outline" },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            separator = {
              --[[ left = "", ]]
              left = " ",
              --[[ right = "", ]]
              right = " ",
            },
            right_padding = 2,
          },
        },
        lualine_b = {
          {
            "branch",
            icon = "",
          },
        },
        lualine_c = {},
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            colored = true,
            update_in_insert = true,
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
          {
            function()
              local buf_clients_name = {}
              local msg = "No Active Lsp"
              local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
              local clients = vim.lsp.get_active_clients()

              if next(clients) == nil then
                return msg
              end

              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
                  table.insert(buf_clients_name, client.name)
                end
              end

              if buf_clients_name then
                return "[" .. table.concat(buf_clients_name, ", ") .. "]"
              else
                return msg
              end
            end,
            icon = " LSP:",
            color = { fg = "#e57474", gui = "bold" },
          },
          { "filetype", colored = true },
        },
        lualine_y = { "progress" },
        lualine_z = {
          {
            "location",
            separator = {
              --[[ left = "", ]]
              left = " ",
              --[[ right = "", ]]
              right = " ",
            },
            left_padding = 0,
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 1,
          },
        },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_a = {
          {
            "tabs",
            tab_max_length = 100,      -- Maximum width of each tab. The content will be shorten dynamically (example: apple/orange -> a/orange)
            max_length = vim.o.columns / 1, -- Maximum width of tabs component.
            mode = 2,
            path = 1,
            show_modified_status = true, -- Shows a symbol next to the tab name if the file has been modified.
            symbols = {
              modified = "[+]",    -- Text to show when the file is modified.
            },

            fmt = function(name, context)
              -- Show + if buffer is modified in tab
              local buflist = vim.fn.tabpagebuflist(context.tabnr)
              local winnr = vim.fn.tabpagewinnr(context.tabnr)
              local bufnr = buflist[winnr]
              local mod = vim.fn.getbufvar(bufnr, "&mod")

              return name .. (mod == 1 and " +" or "")
            end,
          },
        },
      },
    }
  end,
  after = "nvim-base16",
}
