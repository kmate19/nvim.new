vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	-- https://github.com/nvim-treesitter/nvim-treesitter/commit/ab230eadd4a96baec86fb17bd625893649f2612f
	{ src = "https://github.com/lewis6991/ts-install.nvim" },
})

require("ts-install").setup({
	auto_install = true,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function(args)
		if vim.bo[args.buf].buftype ~= "" then
			return
		end

		local ft = vim.bo[args.buf].filetype
		if ft == "" then
			return
		end

		local installed = require("nvim-treesitter").get_installed()
		local has_parser = vim.tbl_contains(installed, ft)

		if has_parser then
			pcall(vim.treesitter.start, args.buf)
		end
	end,
})
