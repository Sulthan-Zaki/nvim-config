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
-- smartcase for search
vim.opt.ignorecase = true
vim.opt.smartcase = true
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

local cmp = require('blink.cmp')
cmp.setup({
	keymap = {
		-- Tab: snippet forward OR select next OR fallback
		['<Tab>']     = {
			function(cmp)
				if cmp.snippet_active() then
					return cmp.snippet_forward()
				else
					return cmp.select_next()
				end
			end,
			'fallback',
		},

		-- Shift+Tab: snippet backward OR select prev OR fallback
		['<S-Tab>']   = {
			function(cmp)
				if cmp.snippet_active() then
					return cmp.snippet_backward()
				else
					return cmp.select_prev()
				end
			end,
			'fallback',
		},

		-- Other VS Code‑like bindings
		['<CR>']      = { 'accept' },
		['<C-Space>'] = { 'show' },
		['<Esc>']     = { 'hide' },
		['<Up>']      = { 'select_prev', 'fallback' },
		['<Down>']    = { 'select_next', 'fallback' },
	},
})

vim.keymap.set('n', '<leader>s', ':set hlsearch!<CR>', { desc = 'Toggle search highlight' })
-- Extra convenience: Map Esc to exit terminal mode (but not close)
vim.keymap.set('t', '<M-q>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
-- Now you can press Ctrl-g then "OK" to get ✓
vim.keymap.set('i', '<C-g>', '<C-k>', { noremap = true })
vim.keymap.set('n', '<leader>e', '%', { desc = 'go to other tags' })
