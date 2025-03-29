local util = require("lspconfig.util")

return {
	cmd = { "pyright" },
	filetypes = { "python" },
	root_dir = util.root_pattern(
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfi.json"
	),
	settings = {
		python = {
			venvPath = ".",
			venv = ".venv",
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
			},
		},
	},
}
