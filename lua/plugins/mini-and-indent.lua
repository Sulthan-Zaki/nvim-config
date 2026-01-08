return {
	{
		-- Background static guides
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		opts = {
			indent = { char = '│' },
			scope = { enabled = false }, -- let mini.indentscope handle scope
		},
	},
	{
		'nvim-mini/mini.nvim',
		version = false,
		config = function()
			require("mini.icons").setup()
			require("mini.diff").setup()
			require("mini.git").setup()
			require("mini.statusline").setup()
			require('mini.indentscope').setup({
				draw = {
					predicate = function(_) return true end, -- draw all scopes
					priority = 20,                      -- draw on top of ibl
					animation = require('mini.indentscope').gen_animation.linear({ duration = 16 }),
				},
				symbol = '│',
			})
			-- Static guides (ibl) color
			-- Current scope (mini) color
			vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = "#9F63FF", bold = true })
			vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbolOff', { link = 'MiniIndentscopeSymbol' })
			require('mini.ai').setup()
			require('mini.surround').setup()
			require('mini.comment').setup()
			require('mini.pairs').setup()
		end
	}
}
