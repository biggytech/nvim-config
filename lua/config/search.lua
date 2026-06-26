function paste_without_new_lines()
	local cb_text = vim.fn.getreg('+')
	local clean_text = cb_text:gsub("[\r\n]+", " ") -- Strips both Unix and Windows newlines
        vim.api.nvim_feedkeys(clean_text, 'n', true)
end

-- Setup Telescope
require('telescope').setup({
  defaults = {
  	layout_strategy = "flex",
  	layout_config = {
  		horizontal = {
	  		width = 0.999,
	     	height = 0.999,
   		},
   		vertical = {
	  		width = 0.999,
	     	height = 0.999,
   		},
   	},
  	path_display = {'filename_first'},
	mappings = {
	      i = {
		-- Overwrite standard Neovim paste shortcuts inside Telescope (Ctrl-v only)
	        ["<C-v>"] = paste_without_new_lines,
        	-- Overwrite the bracketed paste mode that terminals use for Ctrl-Shift-V
	        ["<Paste>"] = paste_without_new_lines,
      		},
    	},
  },
})

-- Wrap Telescope previews
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function()
    vim.wo.wrap = true
  end,
})

-- Enable Telescope (finder / search) keymaps
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>fp', telescope.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>ff', function()
	telescope.live_grep({
		glob_pattern = {
			"**/*",
			"!**/test/**/*",
			"!**/.idea/**/*",
			"!**/.git/**/*",
			"!**/node_modules/**/*",
			"!**/coverage/**/*",
			"!**/build/**/*",
			"!**/playwright-report/**/*",
			"!**/*.log",
			"!**/package-lock.json",
			"!**/open-api-docs.json",
		},
	})
end, { desc = 'Telescope live grep' })

vim.keymap.set('n', '<leader>fc', function()
	telescope.live_grep({
		glob_pattern = {
			"**/*",
			-- "!**/test/**/*",
			-- "!**/.idea/**/*",
			-- "!**/.git/**/*",
			-- "!**/node_modules/**/*",
			-- "!**/coverage/**/*",
			-- "!**/build/**/*",
			-- "!**/playwright-report/**/*",
			-- "!**/*.log",
			-- "!**/package-lock.json",
			-- "!**/open-api-docs.json",
		},
    search_dirs = { vim.fn.expand("%:p:h") }
	})
end, { desc = 'Telescope live grep in current directory' })
vim.keymap.set('n', '<leader>fr', telescope.resume, { desc = 'Resume Telescope search' })

vim.keymap.set('n', '<Esc>', function()
	-- Clear highlights on search when pressing <Esc> in normal mode
	--  See `:help hlsearch`
	vim.cmd("nohlsearch")
end)

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true
