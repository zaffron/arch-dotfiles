return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		-- Speeds up notifications
		require("notify").setup({
			timeout = 2000,
			stages = "static",
		})

		require("noice").setup({
			routes = {
				{
					view = "notify",
					filter = { event = "msg_showmode" },
				},
				{
					-- Hides the savefile message
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
					},
					opts = { skip = true },
				},
			},
			presets = {
				lsp_doc_border = true,
			},
		})
	end,
}
