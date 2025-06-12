return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "ibhagwan/fzf-lua",
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  },
  config = function()
    require("avante").setup({
      provider = "claude", -- "openai",
      providers = {
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
          extra_request_body = {
            timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
            temperature = 0,
            max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
            --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
          },
        },
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-3-5-sonnet-20241022",
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 4096,
          },
        },
      },
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        local mcp_prompt = hub and hub:get_active_servers_prompt() or ""

        -- Your custom default prompt
        local custom_prompt = [[
          I want you to always:
          1. Prioritize using the neovim MCP server for file operations
          2. Use the obsidian MCP server for note-taking and knowledge management
          3. Follow these specific conventions:
             - Always use English for code comments
             - Prefer using native Neovim APIs over external tools
             - Always try to find use context7 mcp for getting the latest documentation about the language or framework I am using
        ]]

        -- Combine custom prompt with MCP prompts
        return custom_prompt .. "\n\n" .. mcp_prompt
      end,
      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
    })
  end,
}
