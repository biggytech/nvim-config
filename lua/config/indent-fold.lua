-- Tabbing and Indentation
require('guess-indent').setup {}

-- Setup treesitter for AST folding
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "typescript", "tsx", "html", "lua", "markdown", "python" },
  highlight = { enable = true },
  indent = { enable = false },
}

-- Plugin to show parent function / method on top of the editor
require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  multiwindow = false, -- Enable multiwindow support.
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Fix folding of files opened via Telescope
function set_file_folds()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
    vim.cmd.normal("zx")
    vim.opt_local.foldlevel = 99
end

-- BufEnter ensures that treesitter finished loading
vim.api.nvim_create_autocmd({"BufReadPost"}, {
  pattern = {"*.js", "*.jsx", "*.ts", "*.tsx"},
  callback = set_file_folds
})
-- Set foldlevel only when buffer is first read/opened
--vim.api.nvim_create_autocmd("BufReadPost", {
--  pattern = {"*.js", "*.jsx", "*.ts", "*.tsx"},
--  callback = function()
    -- Only set foldlevel when buffer is loaded from disk
--    vim.opt_local.foldlevel = 3
--  end
-- })

-- Fix folding of files opened via Telescope
--vim.api.nvim_create_autocmd({ "BufEnter" }, { pattern = { "*" }, command = "normal zx", })
--

-- Every wrapped line will continue visually indented (same amount of
-- space as the beginning of that line), thus preserving horizontal
-- blocks of text.
vim.o.breakindent = true

-- Indent Lines Highlight
require("hlchunk").setup({
  chunk = {
    enable = true,
  },
  indent = {
    enable = true,
    -- Rainbow style
    -- style = {
    -- "#FF0000",
    --  "#FF7F00",
    --  "#FFFF00",
    --  "#00FF00",
    --  "#00FFFF",
    --  "#0000FF",
    --  "#8B00FF",
    -- },
  },
  line_num = {
    enable = true,
  },
})
