return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    -- add any opts here
    -- for example
    provider = "copilot",
    auto_suggestions_provider = 'claude', -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
    behaviour = {
      auto_suggestions = false,           -- don't use this if already using copilot
      auto_suggestions_debounce = 500,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
      minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
    },
    claude = {
      endpoint = 'https://api.anthropic.com',
      model = 'claude-3-5-sonnet-20241022',
      temperature = 0.1, -- kinda creative
      max_tokens = 4096,
    },
    copilot = {
      endpoint = 'https://api.githubcopilot.com/',
      model = 'claude-3.5-sonnet',
      proxy = nil,            -- [protocol://]host[:port] Use this proxy
      allow_insecure = false, -- Do not allow insecure server connections
      timeout = 30000,        -- Timeout in milliseconds
      temperature = 0.1,      -- kinda creative
      max_tokens = 8192,
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
