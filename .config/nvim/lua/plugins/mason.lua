local ensure_installed = {
	"eslint",
	"cssls",
	"cssmodules_ls",
	"emmet_ls",
	"rust_analyzer",
	"lua_ls",
	"jsonls",
	"html",
	"pylsp",
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
		require("mason-lspconfig").setup({
			ensure_installed = ensure_installed,
		})
	end,
}
