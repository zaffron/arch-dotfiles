return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		cmd = "Neotree",
		keys = {
			{ "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
		},
		opts = {
			filesystem = {
				window = {
					mappings = {
						["\\"] = "close_window",
					},
				},
				filtered_items = {
					visible = false,
					show_hidden_count = true,
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_by_name = {
						"node_modules",
						".venv",
						".git",
					},
					always_show = {
						".gitignored",
					},
					always_show_by_pattern = {
						".env*",
					},
					never_show = {
						".git",
					},
				},
			},
		},
	},
}
