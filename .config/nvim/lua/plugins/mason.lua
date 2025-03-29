local ensure_installed = {
	"eslint",
	"cssls",
	"cssmodules_ls",
	"emmet_ls",
	"lua_ls",
	"jsonls",
	"html",
	"pyright",
	"tailwindcss",
	"ts_ls",
	"vtsls",
	"dockerls",
	"bashls",
	"marksman",
	"gopls",
	"astro",
}

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("mason").setup()
		local lspconfig = require("lspconfig")
		local handlers = {
			function(server_name) -- default handler (optional)
				require("lspconfig")[server_name].setup({})
			end,
			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				})
			end,
		}
		require("mason-lspconfig").setup({
			ensure_installed = ensure_installed,
			handlers = handlers,
		})
	end,
}
