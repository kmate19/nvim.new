vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Telescope Search Files" })
vim.keymap.set("n", "<leader>w", builtin.live_grep, { desc = "Telescope Live Grep" })
vim.keymap.set("n", "<leader>wo", function()
	builtin.live_grep({ grep_open_files = true })
end, { desc = "Telescope Live Grep Open Buffers" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope Search Buffers" })

vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
})
require("oil").setup({
	default_file_explorer = true,
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	view_options = {
		show_hidden = true,
		natural_order = false,
		is_always_hidden = function(name, _)
			return name == ".." or name == ".git"
		end,
	},
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory with Oil." })
