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

-- Fix folding of files opened via Telescope
vim.api.nvim_create_autocmd({ "BufEnter" }, { pattern = { "*" }, command = "normal zx", })

-- Enable TypeScript via the Language Server Protocol (LSP)
vim.lsp.enable('tsserver')

-- Set the TS config for the LSP
vim.lsp.config('tsserver', {
  --  Make sure this is on your path
  cmd = {'typescript-language-server', '--stdio'},
  filetypes = { 'typescript', "typescriptreact", "typescript.tsx" },
  -- This is a hint to tell nvim to find your project root from a file within the tree
  root_dir = vim.fs.root(0, {'package.json', '.git'}),
  on_attach = on_attach,
  capabilities = capabilities,
  -- optional settings = {...} go here, refer to language server code: https://github.com/typescript-language-server/typescript-language-server/blob/5c483349b7b4b6f79d523f8f4d854cbc5cec7ecd/src/ts-protocol.ts#L379
})

-- LSP keymaps
vim.keymap.set('n', '<leader>er', vim.lsp.buf.rename, {})
vim.keymap.set('n', '<leader>nd', vim.lsp.buf.definition, {})
-- format by LSP
-- vim.keymap.set('n', '<leader>f', function()
--  vim.lsp.buf.format { async = true }
--end, {})
vim.keymap.set('n', '<leader>.', vim.diagnostic.open_float, {})
