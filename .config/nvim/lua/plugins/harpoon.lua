return {
  "thePrimeagen/harpoon",
  enabled = true,
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup({
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
      },
    })

    --Harpoon Nav Interface
    vim.keymap.set("n", "<leader>ha", function()
      harpoon:list():add()
    end, { desc = "Harpoon add file" })

    vim.keymap.set("n", "<leader>hl", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon list" })

    --Harpoon marked files
    vim.keymap.set("n", "<leader>h1", function()
      harpoon:list():select(1)
    end, { desc = "Harpoon select 1" })
    vim.keymap.set("n", "<leader>h2", function()
      harpoon:list():select(2)
    end, { desc = "Harpoon select 2" })
    vim.keymap.set("n", "<leader>h3", function()
      harpoon:list():select(3)
    end, { desc = "Harpoon select 3" })
    vim.keymap.set("n", "<leader>h4", function()
      harpoon:list():select(4)
    end, { desc = "Harpoon select 4" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>hp", function()
      harpoon:list():prev()
    end, { desc = "Harpoon previous buffer" })
    vim.keymap.set("n", "<leader>hn", function()
      harpoon:list():next()
    end, { desc = "Harpoon next buffer" })
  end,
}
