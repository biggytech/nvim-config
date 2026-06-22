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
			-- lazy spec to build "microsoft/vscode-js-debug" from source
			{
				"microsoft/vscode-js-debug",
				tag = "v1.97.0",
				build = "npm i --ignore-scripts && npm run compile dapDebugServer && mv dist out"
			},
		},
	},
  -- Indent Lines Highlight
  {
    'shellraining/hlchunk.nvim',
    commit = '06f51922ca43d5cdacf96725c106405fe064c59e',
    event = { "BufReadPre", "BufNewFile" },
  },
  -- Bookmarks
  {
    'MattesGroeger/vim-bookmarks',
    commit = '9cc5fa7ecc23b052bd524d07c85356c64b92aeef'
  },
  -- Harpoon
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", version = '.0.1.4' },
    commit = '87b1a3506211538f460786c23f98ec63ad9af4e5'
  }
}
