return {
  -- Search files and in files
	{
   	'nvim-telescope/telescope.nvim',
   	version = '0.2.1',
 		dependencies = {
			{ 'nvim-lua/plenary.nvim', version = '0.1.4', },
   		{
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
			  commit = '6fea601bd2b694c6f2ae08a6c6fab14930c60e2c'
      },
			{ 'nvim-treesitter/nvim-treesitter', version = '0.10.0' }
    }
	},
	-- Group Live grep results by file
        {
                "fdschmidt93/telescope-egrepify.nvim",
                commit = 'cd9342b95c1a8cff2e41ba5041ae3912f47595cc',
                -- Deps already installed
                -- dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
        }
}
