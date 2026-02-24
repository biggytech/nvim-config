return {
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		-- See `:help gitsigns` to understand what the configuration keys do
		'lewis6991/gitsigns.nvim',
		version = '2.0.0',
		opts = {
			signs = {
				add = { text = '┃' },
				change = { text = '┃' },
				delete = { text = '┃' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
				untracked = { text = '┆' },
			},
		},
  	},
}
