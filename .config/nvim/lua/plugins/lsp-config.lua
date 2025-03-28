return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v4.x",
	enabled = false,
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" },
		{
			"williamboman/mason.nvim",
			build = function()
				pcall(vim.cmd, "MasonUpdate")
			end,
		},
		{ "williamboman/mason-lspconfig.nvim" },

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "L3MON4D3/LuaSnip" },
		{ "rafamadriz/friendly-snippets" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "pmizio/typescript-tools.nvim" },
		{ "nvim-lua/plenary.nvim" },
	},

	config = function()
		local lsp_zero = require("lsp-zero")

		lsp_zero.extend_lspconfig()

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"eslint",
				"rust_analyzer",
				"lua_ls",
				"jsonls",
				"html",
				"pylsp",
				"dockerls",
				"bashls",
				"marksman",
				"cucumber_language_server",
				"gopls",
				"astro",
			},
			handlers = {
				lsp_zero.default_setup,
				lua_ls = function()
					require("lspconfig").lua_ls.setup(lsp_zero.nvim_lua_ls())
				end,
			},
		})

		-- Keymaps when LSP attaches
		lsp_zero.on_attach(function(_, bufnr)
			local map = vim.keymap.set
			map("n", "gr", vim.lsp.buf.references, { desc = "LSP Goto Reference", buffer = bufnr })
			map("n", "gd", vim.lsp.buf.definition, { desc = "LSP Goto Definition", buffer = bufnr })
			map("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover", buffer = bufnr })
			map("n", "<leader>vws", vim.lsp.buf.workspace_symbol, { desc = "LSP Workspace Symbol", buffer = bufnr })
			map("n", "<leader>vd", vim.diagnostic.setloclist, { desc = "LSP Show Diagnostics", buffer = bufnr })
			map("n", "[d", vim.diagnostic.jump, { desc = "Next Diagnostic", buffer = bufnr, count = 1, float = true })
			map(
				"n",
				"]d",
				vim.diagnostic.jump,
				{ desc = "Previous Diagnostic", buffer = bufnr, count = 1, float = true }
			)
			map("n", "<leader>vca", vim.lsp.buf.code_action, { desc = "LSP Code Action", buffer = bufnr })
			map("n", "<leader>vce", function()
				vim.diagnostic.open_float(nil, { focusable = false })
			end, { desc = "Show error message", buffer = bufnr })
			map("n", "<leader>vrr", vim.lsp.buf.references, { desc = "LSP References", buffer = bufnr })
			map("n", "<leader>vrn", vim.lsp.buf.rename, { desc = "LSP Rename", buffer = bufnr })
			map("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "LSP Signature Help", buffer = bufnr })
		end)

		-- Typescript tools setup
		require("typescript-tools").setup({
			on_attach = function(client, bufnr)
				lsp_zero.on_attach(client, bufnr)
			end,
		})

		-- CMP Setup
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),
		})

		-- Optional: cmdline completion
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})
	end,
}
