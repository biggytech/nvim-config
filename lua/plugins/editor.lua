return {
	-- Show parent function / method on top of the editor
	{ "nvim-treesitter/nvim-treesitter-context", version = "1.0.0" },

	-- Highlight todo, notes, etc in comments
	{
		'folke/todo-comments.nvim',
		version = "1.5.0",
		event = 'VimEnter',
		dependencies = {
			{ 'nvim-lua/plenary.nvim', version = '0.1.4' }
		},
		opts = {
			signs = false,
			keywords = {
				TODO = { color = "warning" },
  			},
		}
	},
	{
		'nvim-lualine/lualine.nvim',
		commit = '8811f3f3f4dc09d740c67e9ce399e7a541e2e5b2',
		dependencies = {
			{
				'nvim-tree/nvim-web-devicons',
				commit = '95b7a002d5dba1a42eb58f5fac5c565a485eefd0'
			}
		}
	},
	-- Debugger
	{
		'mfussenegger/nvim-dap',
		version = "0.10.0",
		lazy = true,
		dependencies = {
			{
				'rcarriga/nvim-dap-ui',
				version = '4.0.0',
				dependencies = {
					{
						'nvim-neotest/nvim-nio',
						version = '1.10.1'
					}
				}
			},
			-- lazy spec to build "microsoft/vscode-js-debug" from source
			{
				"microsoft/vscode-js-debug",
				tag = "v1.97.0",
				build = "npm i --ignore-scripts && npm run compile dapDebugServer && mv dist out"
			},
		},
	}
}
