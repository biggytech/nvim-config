-- Set leader key to Space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("config.lazy")

-- Load .vimrc file
vim.cmd("runtime ./.vimrc")

-- Set Color Theme (Scheme)
vim.api.nvim_set_option_value("background", "light", {})
vim.cmd("colorscheme edge")

-- Enable Telescope (finder / search) keymaps
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>fp', telescope.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>ff', function()
	telescope.live_grep({
		glob_pattern = { "**/*", "!**/test/**/*", "!**/.idea/**/*", "!**/.git/**/*" },
	})
end, { desc = 'Telescope live grep' })

-- Command to copy file path
vim.keymap.set('n', '<leader>p', function ()
	vim.fn.setreg('+', vim.fn.expand('%:p'))
end, { desc = 'Copy Current Buffer Path' })

-- Command to copy file relative path
vim.keymap.set('n', '<leader>pr', function ()
	vim.fn.setreg('+', vim.fn.expand('%'))
end, { desc = 'Copy Current Buffer Relative Path' })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
