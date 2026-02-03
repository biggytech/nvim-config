return {
	{
    		'nvim-telescope/telescope.nvim',
		version = '0.2.1',
 		dependencies = {
			{ 'nvim-lua/plenary.nvim', version = '0.1.4', },
        		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			{ 'nvim-treesitter/nvim-treesitter', version = '0.10.0' }
    		}
	}
}
