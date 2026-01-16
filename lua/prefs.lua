vim.g.mapleader = " "
vim.g.localleader = " "

vim.opt.termguicolors = true
vim.g.have_nerd_font = true

-- highlight line on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

local M = vim.keymap

-- move lines up and down in visual mode
M.set("v", "J", ":m '>+1<CR>gv=gv")
M.set("v", "K", ":m '<-2<CR>gv=gv")

-- Clear highlights on search when pressing <Esc> in normal mode
M.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- ability to replace text without copying
M.set("x", "<leader>p", [["_dP]])
-- Diagnostic keymaps
M.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- quick command mode in normal mode
M.set("n", ";", ":")

-- black hole register for c, r and x so its not annoying
M.set("n", "x", '"_x')
M.set("n", "c", '"_c')
M.set("n", "r", '"_r')

-- center things
-- M.set('n', 'J', 'mzJ`z')
M.set("n", "<C-d>", "<C-d>zz")
M.set("n", "<C-u>", "<C-u>zz")
-- M.set('n', 'n', 'nzzzv')
-- M.set('n', 'N', 'Nzzzv')

-- tmux
M.set("n", "<C-h>", "<cmd>wincmd h<CR>")
M.set("n", "<C-j>", "<cmd>wincmd j<CR>")
M.set("n", "<C-k>", "<cmd>wincmd k<CR>")
M.set("n", "<C-l>", "<cmd>wincmd l<CR>")

local O = vim.opt

vim.diagnostic.config({ virtual_text = false, virtual_lines = false })

O.winborder = "solid"

-- clipboard unnamedplus for system clipboard
O.clipboard = "unnamedplus"

---- indenting
O.shiftwidth = 4
O.tabstop = 4
O.softtabstop = 4

-- spaces instead of tabs
O.expandtab = true
O.autoindent = true
O.smartindent = true
O.breakindent = true

-- (no) folding
O.foldenable = false
O.foldmethod = "manual"
O.foldlevelstart = 99

-- linewrap
O.wrap = false

-- swapfile/undofile
O.swapfile = false
O.undofile = true

-- line numbers
O.relativenumber = true
O.nu = true

-- usable mouse in all modes
O.mouse = "a"

-- search
O.ignorecase = true
O.smartcase = true

-- no beep
O.vb = true

-- signcolumn
O.signcolumn = "yes"

-- update time for swapfile and cursorhold (not using swap)
O.updatetime = 400

-- how long to wait for keypresses after pressing a modifier key eg. <C>
O.timeoutlen = 400

-- split settings
O.splitright = true
O.splitbelow = true

-- change how chars look in list mode
O.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- prettier replace view
O.inccommand = "split"

-- i like big scrolloff
O.scrolloff = 8

-- line at 80 for code line length sanity
O.colorcolumn = "80"
