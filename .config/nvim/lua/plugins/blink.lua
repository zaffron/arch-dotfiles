return {

  { "L3MON4D3/LuaSnip", keys = {} },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "Kaiser-Yang/blink-cmp-avante",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    opts_extend = { "sources.default", "cmdline.sources", "term.sources" },
    version = "*",
    config = function()
      require("blink.cmp").setup({
        snippets = { preset = "luasnip" },
        signature = { enabled = true },
        appearance = {
          use_nvim_cmp_as_default = false,
          nerd_font_variant = "normal",
        },
        sources = {
          default = { "avante", "lsp", "path", "snippets", "buffer" },
          providers = {
            avante = {
              module = "blink-cmp-avante",
              name = "Avante",
              opts = {},
            },
            cmdline = {
              min_keyword_length = 2,
            },
          },
        },
        keymap = {
          -- I will try to learn this, liking C-y better
          preset = "default",
        },
        cmdline = {
          enabled = true,
          completion = { menu = { auto_show = true } },
        },
        completion = {
          menu = {
            border = "none",
            scrolloff = 1,
            scrollbar = false,
            draw = {
              columns = {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
                { "kind" },
                { "source_name" },
              },
            },
          },
          documentation = {
            window = {
              border = "rounded",
              scrollbar = false,
            },
            auto_show = true,
            auto_show_delay_ms = 500,
          },
        },
      })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
