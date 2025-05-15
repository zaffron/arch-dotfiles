return {
  "todo",
  dir = vim.fn.expand("$HOME") .. "/Developer/custom-nvim-plugins/todo.nvim",
  config = function()
    require("todo").setup()
  end,
}
