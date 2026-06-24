-- Git Blame
local git_blame = require('gitblame')
git_blame.setup({
	message_template = "<date> • <summary> • <author>",
        date_format = "%r",
})
-- Git Blame Custom Floating window
vim.keymap.set('n', '<leader>gb', function()
	vim.lsp.util.open_floating_preview({
		git_blame.get_current_blame_text()
	})
end, { desc = 'Open Git Blame Custom Floating window' })
vim.keymap.set('n', '<leader>go', function()
	git_blame.open_commit_url()
end, { desc = 'Open Git Commit URL' })
