return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "python",
          "javascript",
          "typescript",
          "toml",
          "json",
          "gitignore",
          "yaml",
          "bash",
          "tsx",
          "css",
          "html",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        fold = { enable = true },
      })
    end,
  },
}
