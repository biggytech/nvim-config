-- LSP keymaps
vim.keymap.set('n', '<leader>er', vim.lsp.buf.rename, {})
vim.keymap.set('n', '<leader>nd', vim.lsp.buf.definition, {})
-- Show LSP diagnostic window
vim.keymap.set('n', '<leader>.', vim.diagnostic.open_float, {})

-- Show diagnostic message right in the code (virtual text)
-- 1. Setup diagnostic UI defaults
vim.diagnostic.config({
  virtual_text = true,
})

-- Create an augroup for managing diagnostic visibility
local diagnostic_group = vim.api.nvim_create_augroup("DiagnosticInsertToggle", { clear = true })

-- Hide virtual text when entering Insert Mode
vim.api.nvim_create_autocmd("InsertEnter", {
  group = diagnostic_group,
  callback = function()
    vim.diagnostic.config({ virtual_text = false })
  end,
})
-- Show virtual text when leaving Insert Mode
vim.api.nvim_create_autocmd("InsertLeave", {
  group = diagnostic_group,
  callback = function()
    vim.diagnostic.config({ virtual_text = true })
  end,
})

-- Save file & Run Prettier on hotkey
vim.keymap.set('n', '<leader>s', function()
  -- Save the file silently
  vim.cmd('silent w')

  vim.cmd('silent! TSToolsAddMissingImports')

  vim.cmd('silent! PrettierCli --write ' .. vim.fn.expand('%:p'))
  vim.cmd('silent! edit!')

  vim.cmd('silent w')

	vim.notify('File saved!')
	set_file_folds()
end, { desc = 'Save & Format File' })

-- Keep signcolumn on by default
-- Helps to avoid "flickering/shifting" of this column
-- when error / sign appears / dissapears
vim.o.signcolumn = 'yes'

-- Copy Diagnostic window contents
vim.keymap.set('n', '<leader>,', function()
	local line = vim.api.nvim_win_get_cursor(0)[1]
	local diagnostics = vim.diagnostic.get(0, { lnum = line - 1 })

	-- empty the register first
	vim.fn.setreg('+', {}, 'V')

	for _, diagnostic in ipairs(diagnostics) do
	  vim.fn.setreg(
	    '+',
	    vim.fn.getreg('+') .. diagnostic["message"],
	    'V'
	  )
	end

	vim.notify('Copied diagnostics info to the clipboard!')
end, { desc = 'Copy Diagnostic window contents' })

-- Disable LSP log to save memory
vim.lsp.set_log_level("off")
