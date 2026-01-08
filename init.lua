vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- keybinds for nvim-tree
vim.keymap.set("n", "<leader>fe", ":NvimTreeToggle<CR>", { desc = "Toggle tree explorer" })

require("config.lazy")

vim.diagnostic.config({
	virtual_text = {
		prefix = "●", -- or ">>" or any symbol
		spacing = 2,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.WARN] = '',
			[vim.diagnostic.severity.INFO] = '',
			[vim.diagnostic.severity.HINT] = '󰌵',
		},
		numhl = {
			[vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
			[vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
		}
	},
	underline = true,
	update_in_insert = false,
})


vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight yanking',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'python', 'go', 'typescriptreact', 'html', 'javascriptreact', "javascript" },
	callback = function()
		vim.treesitter.start()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
})
