-- Set Color Theme (Scheme)
vim.api.nvim_set_option_value("background", "light", {})
vim.cmd("colorscheme edge")
-- Change diagnostic error message color (override theme value)
vim.cmd("hi! DiagnosticVirtualTextError guifg=#C40C0C")

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Show which line your cursor is on (highlight)
vim.o.cursorline = true

-- Set custom colors for gitsigns highlight groups
vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#48A111", bg = "NONE" }) -- Green for additions
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#F2B50B", bg = "NONE" }) -- Yellow for changes
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#C40C0C", bg = "NONE" }) -- Red for deletions

-- Change cursor colors
vim.opt.guicursor = {
  "n:block-NormalCursor",
  "i:ver25-iCursor",
  "v:block-NormalCursor",
}
vim.cmd("highlight NormalCursor guifg=NONE guibg=#314E63 gui=NONE")
vim.cmd("highlight iCursor guifg=NONE guibg=#000000 gui=NONE") -- Insert mode

-- Lua Line
require('lualine').setup({
	options = {
		theme = 'ayu_light',
		globalstatus = true,
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {
			{
				'filename',
				path = 1
			}
		},
		lualine_x = {
			'lsp_status',
		},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	}

})
