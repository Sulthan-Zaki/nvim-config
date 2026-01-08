return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			'saghen/blink.cmp',
			{
				"folke/lazydev.nvim",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			-- old style config adding
			-- vim.lsp.config("lua_ls", {
			-- 	filetypes = { "lua" },
			-- 	root_markers = {
			-- 		".git",    -- project root if git repo
			-- 		".luarc.json", -- lua-language-server config file
			-- 		".luarc.jsonc", -- alternative config
			-- 		"init.lua"
			-- 	}
			-- })
			-- gi go to implementation and format after write
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('my.lsp', {}),
				callback = function(args)
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
					if client:supports_method('textDocument/implementation') then
						vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "go to implementation" })
					end
					-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
					-- Auto-format ("lint") on save.
					-- Usually not needed if server supports "textDocument/willSaveWaitUntil".
					if not client:supports_method('textDocument/willSaveWaitUntil')
							and client:supports_method('textDocument/formatting') then
						vim.api.nvim_create_autocmd('BufWritePre', {
							group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
							end,
						})
					end
				end,
			})
			-- 1. Create capabilities with Blink
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
			-- 2. Set default config for all servers
			-- vim.lsp.enable("lua_ls")
			-- vim.lsp.enable("gopls")
			-- vim.lsp.enable("pyright")
			-- vim.lsp.enable("html")
			-- vim.lsp.enable("ts_ls")
			vim.lsp.config('*',{
				capabilities = capabilities,
			})
		end,
	}
}
