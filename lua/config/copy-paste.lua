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
  local end_line = start_line + count - 1
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

-- Paste from system clipboard in insert mode using Ctrl-V
vim.keymap.set('i', '<C-v>', '<C-r>+', { noremap = true, silent = true })
