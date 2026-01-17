if vim.pack == nil then
	vim.notify("This config requires vim.pack feature", vim.log.levels.ERROR)
	return 1
end

require("prefs")

require("lsp")
require("telescope")
require("mini")

vim.pack.add({
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
})

vim.cmd.colorscheme("kanagawa")
