return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  keys = {
    { "<leader>a", "<Cmd>AvanteAsk<Cr>", mode = { "n", "v" } },        -- Open Avante Ask
    { "<leader>af", "<Cmd>AvanteFocus<Cr>", mode = { "n", "v" } },      -- Focus Avante
    { "<leader>ac", "<Cmd>AvanteClear<Cr>", mode = { "n", "v" } },      -- Clear Avante
    { "<leader>as", "<Cmd>AvanteStop<Cr>", mode = { "n", "v" } },       -- Stop Avante
    { "<leader>cc", "<Cmd>AvanteAsk Please read the buffer and elaborate a commit message for this change. The commit change must semantic commit message with a title 50 characters long, and a body that wraps at 72 characters with the proposed changes. The body should be formatted as a list of changes. The commit message should not include any author or co-author lines. Be careful to remove the first empty line at the beginning. Thanks!<Cr>", mode = { "n" } }, -- Generate commit message
  },
  opts = {
    provider = "copilot",
    auto_suggestions_provider = "copilot",
    providers = {
      copilot = {
        -- model = "claude-3.7-sonnet"
        -- model = "gpt-4o", -- or any other model you prefer
        -- model = "gpt-4.1", -- or any other model you prefer
        model = "claude-sonnet-4", -- or any other model you prefer
      },
      openai = {
        endpoint = "https://api.githubcopilot.com",
        model = "", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- timeout in milliseconds
        extra_request_body = {
          temperature = 0, -- adjust if needed
          max_tokens = 4096,
          -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
        },
      },
    },
    behaviour = {
      auto_suggestions = false, -- Experimental stage
    },
    windows = {
      ---@type "right" | "left" | "top" | "bottom"
      position = "right", -- the position of the sidebar
      wrap = true, -- similar to vim.o.wrap
      width = 50, -- default % based on available width
      sidebar_header = {
        enabled = true, -- true, false to enable/disable the header
        align = "center", -- left, center, right for title
        rounded = true,
      },
      -- I liked the default, but I comment out this section for future references
      -- input = {
      --   prefix = "> ",
      --   height = 8, -- Height of the input window in vertical layout
      -- },
      edit = {
        border = "rounded",
        start_insert = true, -- Start insert mode when opening the edit window
      },
      ask = {
        floating = false, -- Open the 'AvanteAsk' prompt in a floating window
        start_insert = true, -- Start insert mode when opening the ask window
        border = "rounded",
        ---@type "ours" | "theirs"
        focus_on_apply = "ours", -- which diff to focus after applying
      },
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
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
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
