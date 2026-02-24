return {
	-- Show parent function / method on top of the editor
	{ "nvim-treesitter/nvim-treesitter-context", version = "1.0.0" },
	-- Highlight todo, notes, etc in comments
	{
		'folke/todo-comments.nvim',
		version = "1.5.0",
		event = 'VimEnter',
		dependencies = {
			'nvim-lua/plenary.nvim'
		},
		opts = {
			signs = false,
			keywords = {
				TODO = { color = "warning" },
  			},
		}
	},
}
