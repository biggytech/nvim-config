-- Set leader key to Space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("config.lazy")

-- Load .vimrc file
vim.cmd("runtime ./.vimrc")

-- Set Color Theme (Scheme)
vim.cmd("colorscheme edge")

-- Enable Telescope (finder / search) keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', function(opts)
	builtin.live_grep({
		glob_pattern = { "**/*", "!**/test/**/*", "!**/.idea/**/*", "!**/.git/**/*" }
	})
end, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Enable break indent
vim.o.breakindent = false
