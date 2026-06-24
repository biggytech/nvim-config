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

-- Highlight Pending move (yy, dd)
local ns_id = vim.api.nvim_create_namespace("operator_preview")

-- Clear any leftover highlights
local function clear_preview()
  vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
end

-- Core function to calculate and highlight the line range
local function highlight_operator_range(operator)
  clear_preview()
  
  -- Grab the number entered before pressing y or d (defaults to 1 if no count)
  local count = vim.v.count1 
  local start_line = vim.fn.line(".") - 1
  local end_line = start_line + count
  local max_line = vim.api.nvim_buf_line_count(0)
  
  if end_line > max_line then end_line = max_line end

  -- Apply background highlight to the targeted line range
  for i = start_line, end_line - 1 do
    vim.api.nvim_buf_set_extmark(0, ns_id, i, 0, {
      line_hl_group = "Visual", -- Change to "IncSearch" or "Search" if you want brighter colors
      end_line = i + 1,
    })
  end
  
  -- Force Neovim to redraw the screen immediately so the highlight displays
  vim.cmd("redraw")
  
  -- Return the native keys back to Neovim to complete the action seamlessly
  return operator
end

-- Bind 'y' and 'd' to evaluate the highlight function first
vim.keymap.set("n", "y", function() return highlight_operator_range("y") end, { expr = true })
vim.keymap.set("n", "d", function() return highlight_operator_range("d") end, { expr = true })

-- Automatically clear the highlight once the action finishes, moves, or changes
vim.api.nvim_create_autocmd({ "TextYankPost", "CursorMoved", "InsertEnter", "BufLeave" }, {
  callback = clear_preview,
})

