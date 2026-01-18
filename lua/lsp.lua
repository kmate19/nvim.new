vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		css = { "prettierd" },
		rust = { "rustfmt", lsp_format = "fallback" },
		html = { "prettierd" },
		typescriptreact = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescript = { "prettierd" },
		javascript = { "prettierd" },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua_ls",
		"stylua",
	},
})

require("blink.cmp").setup({
	keymap = { preset = "enter" },

	signature = {
		enabled = true,
		trigger = {
			show_on_keyword = true,
			show_on_insert = true,
		},
		window = {
			border = "none",
			direction_priority = { "s", "n" },
		},
	},
})

-- this causes flickering with highlights when enabled currently for me
vim.lsp.semantic_tokens.enable(false)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

		map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

		map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

		map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

		map("<leader>tt", require("telescope.builtin").diagnostics, "[T]oggle [T]agbar")

		map("E", vim.diagnostic.open_float, "Open diagnostic float")

		map("K", vim.lsp.buf.hover, "Open diagnostic float")

		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

		map("<leader>a", vim.lsp.buf.code_action, "[C]ode [A]ction")

		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			cargo = { features = "all" },
			diagnostics = {
				styleLints = {
					enable = true,
				},
			},
		},
	},
})

vim.lsp.enable("rust_analyzer")

require("fidget").setup()
