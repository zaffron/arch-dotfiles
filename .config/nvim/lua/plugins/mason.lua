return {
  "mason-org/mason.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "jay-babu/mason-nvim-dap.nvim",
  },
  event = "VeryLazy",
  config = function()
    local ensure_installed = {
      -- LSP servers
      "eslint",
      "cssls",
      "cssmodules_ls",
      "emmet_ls",
      "lua_ls",
      "jsonls",
      "html",
      "pyright",
      "tailwindcss",
      -- "vtsls",
      "dockerls",
      "bashls",
      "marksman",
      "gopls",
    }
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
    mason_lspconfig.setup({
      ensure_installed = ensure_installed,
      automatic_enable = true,
    })

    -- Set up mason-nvim-dap
    require("mason-nvim-dap").setup({
      ensure_installed = {
        "debugpy",
        "delve",
        "js-debug-adapter",
      },
      automatic_installation = true,
      handlers = {
        function(config)
          -- all sources with no handler get passed here
          -- Keep original functionality
          require("mason-nvim-dap").default_setup(config)
        end,
        python = function(config)
          config.adapters = {
            type = "executable",
            command = "python",
            args = {
              "-m",
              "debugpy.adapter",
            },
          }
          require("mason-nvim-dap").default_setup(config) -- don't forget this
        end,
      },
    })

    vim.lsp.config("pyright", {
      settings = {
        filetypes = { "python" },
        root_markers = {
          "pyproject.toml",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
          "Pipfile",
          "pyrightconfi.json",
        },
        python = {
          venvPath = ".",
          venv = ".venv",
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
        },
      },
    })
  end,
}
