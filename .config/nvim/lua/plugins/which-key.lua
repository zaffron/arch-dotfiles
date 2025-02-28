return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  lazy = true,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-keys)"
    }
  },
  config = function()
    require("which-key").setup()
  end,
}
