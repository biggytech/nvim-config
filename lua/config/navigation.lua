-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
  vim.notify('File added to Harpoon!')
end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
-- Highlight current file in the harpoon buffer list
local harpoon_extensions = require("harpoon.extensions")
harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

-- Add vim.notify text for vim-bookmarks commands
vim.keymap.set("n", "mc", function()
  vim.cmd("BookmarkClear")
  vim.notify('Cleared bookmarks in the current buffer!')
end)
vim.keymap.set("n", "mx", function()
  vim.cmd("BookmarkClearAll")
  vim.notify('Cleared bookmarks in the all buffers!')
end)

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next({ keywords = { "TODO" } })
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev({ keywords = { "TODO" } })
end, { desc = "Previous todo comment" })

-- Close Quickfix window
vim.keymap.set('n', '<leader>q', function()
	vim.cmd('cclose')
end, { desc = 'Close Quickfix window' })

