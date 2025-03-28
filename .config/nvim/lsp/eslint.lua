---@type vim.lsp.Config
return {
	cmd = { "eslint", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_dir = require("lspconfig.util").root_pattern(
		".eslintrc",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.json",
		"package.json",
		".git"
	),
	settings = {
		validate = "on",
		packageManager = "npm",
		codeActionOnSave = {
			enable = true,
			mode = "all",
		},
		format = true,
	},
}
