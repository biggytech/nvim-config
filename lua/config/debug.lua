-- TypeScript & JavaScript Debugger
local js_debug_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/src/dapDebugServer.js"
local js_adapter = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
	command = "node",
		args = { js_debug_path, "${port}" },
	}
}

local function js_adapter_fn(cb, config)
	-- Make pwa-node compatible with 'node' configs in .vscode/launch.json files
	config.type = "pwa-node"
	-- Fix the source map offset problem. vscode-js-debug needs smartStep to skip over unmapped compiled lines and land on the correct original line
	config.smartStep = true
	config.sourceMaps = true


	-- Fix: nvim-dap resolves ${workspaceFolder} but not the older ${workspaceRoot} alias
	local workspace = vim.fn.getcwd()
	local function resolve(val)
		if type(val) == "string" then
			return val:gsub("${workspaceRoot}", workspace):gsub("${workspaceFolder}", workspace)
		end
		return val
	end

	config.localRoot = resolve(config.localRoot)
	config.cwd = resolve(config.cwd)
	if config.outFiles then
		for i, v in ipairs(config.outFiles) do
			config.outFiles[i] = resolve(v)
		end
	end

	cb(js_adapter)
end

require("dap").adapters["pwa-node"] = js_adapter_fn
require("dap").adapters["node"] = js_adapter_fn

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

vim.keymap.set('n', '<leader>db', function()
	require('dap').toggle_breakpoint()
end, { desc = 'Set Debug Breakpoint' })
vim.keymap.set('n', '<leader>dc', function()
	require('dap').continue()
end, { desc = 'Continue Debug Execution (Resume / Start)' })

local widgets = require("dap.ui.widgets")
vim.keymap.set("n", "I", widgets.hover, { desc = "Debug: Inspect variable" })
vim.keymap.set("v", "I", widgets.hover, { desc = "Debug: Inspect selection" })
-- Close debug window on Esc or q
vim.api.nvim_create_autocmd("FileType", {
    pattern = "dap-float",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close!<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<cmd>close!<CR>", { noremap = true, silent = true })
    end
})
