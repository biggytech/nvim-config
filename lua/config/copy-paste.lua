-- Command to copy file relative path
vim.keymap.set('n', '<leader>r', function ()
	local path = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':~:.')
	vim.fn.setreg('+', path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, { desc = 'Copy Current Buffer Relative Path' })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
