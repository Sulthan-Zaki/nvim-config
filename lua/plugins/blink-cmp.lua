return {
	'saghen/blink.cmp',
	dependencies = { 'rafamadriz/friendly-snippets' },
	version = 'v0.*',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- Place your custom keymaps here inside the opts table
		keymap = {
			['<CR>'] = { 'accept', 'fallback' },
			['<C-Space>'] = { 'show', 'fallback' },
			['<Esc>'] = { 'hide', 'fallback' },
			['<Up>'] = { 'select_prev', 'fallback' },
			['<Down>'] = { 'select_next', 'fallback' },

			['<Tab>'] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.snippet_forward()
					else
						return cmp.select_next()
					end
				end,
				'fallback',
			},

			['<S-Tab>'] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.snippet_backward()
					else
						return cmp.select_prev()
					end
				end,
				'fallback',
			},
		},
		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},
		signature = { enabled = true },
		appearance = { nerd_font_variant = 'mono' },
		completion = { documentation = { auto_show = false } },
		fuzzy = { implementation = "prefer_rust_with_warning" }
	},
	opts_extend = { "sources.default" }
}
