---@type vim.lsp.Config
return {
	cmd = { "jsonls", "--stdio" },
	filetypes = { "json", "jsonc" },
}
