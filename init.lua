-- Set leader key to Space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("config.lazy")

-- Load .vimrc file
vim.cmd("runtime ./.vimrc")

-- Set Color Theme (Scheme)
vim.api.nvim_set_option_value("background", "light", {})
vim.cmd("colorscheme edge")
-- Change diagnostic error message color (override theme value)
vim.cmd("hi! DiagnosticVirtualTextError guifg=#C40C0C")

-- Setup Telescope
require('telescope').setup({
    defaults = {
	layout_strategy = "flex",
	layout_config = {
		horizontal = {
			width = 0.999,
	        	height = 0.999,
      		},
      		vertical = {
			width = 0.999,
	        	height = 0.999,
      		},
    	},
    }
})

-- Wrap Telescope previews
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function()
    vim.wo.wrap = true
  end,
})

-- Enable Telescope (finder / search) keymaps
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>fp', telescope.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>ff', function()
	telescope.live_grep({
		glob_pattern = {
			"**/*",
			"!**/test/**/*",
			"!**/.idea/**/*",
			"!**/.git/**/*",
			"!**/node_modules/**/*",
			"!**/coverage/**/*",
			"!**/build/**/*",
			"!**/playwright-report/**/*",
			"!**/*.log",
			"!**/package-lock.json",
			"!**/open-api-docs.json",
		},
	})
end, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fr', telescope.resume, { desc = 'Resume Telescope search' })

-- Command to copy file path
vim.keymap.set('n', '<leader>p', function ()
	local path = vim.fn.expand('%:p')
	vim.fn.setreg('+', path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, { desc = 'Copy Current Buffer Path' })

-- Command to copy file relative path
vim.keymap.set('n', '<leader>r', function ()
	local path = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':~:.')
	vim.fn.setreg('+', path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, { desc = 'Copy Current Buffer Relative Path' })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- LSPs

-- TypeScript
vim.lsp.enable('tsserver')
-- Set the TS config for the LSP
vim.lsp.config('tsserver', {
  --  Make sure this is on your path
  cmd = {'typescript-language-server', '--stdio'},
  filetypes = {
	  'typescript',
	  "typescriptreact",
	  "typescript.tsx",
	  'javascript',
	  "javascriptreact",
	  "javascript.jsx",
  },
  -- This is a hint to tell nvim to find your project root from a file within the tree
  root_dir = vim.fs.root(0, {'package.json', '.git'}),
  on_attach = on_attach,
  capabilities = capabilities,
  -- optional settings = {...} go here, refer to language server code: https://github.com/typescript-language-server/typescript-language-server/blob/5c483349b7b4b6f79d523f8f4d854cbc5cec7ecd/src/ts-protocol.ts#L379
})

-- Python
vim.lsp.enable('basedpyright')
vim.lsp.config('basedpyright', {
  --  Make sure this is on your path
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = {
	"python"
  },
  on_attach = on_attach,
  capabilities = capabilities,
  -- This is a hint to tell nvim to find your project root from a file within the tree
  root_markers = {
    'pyrightconfig.json',
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'openFilesOnly',
        -- https://docs.basedpyright.com/latest/configuration/language-server-settings/
        -- Explicitly setting `basedpyright.analysis.useLibraryCodeForTypes` is **discouraged** by the official docs.
        -- Because it will override per-project configurations like `pyproject.toml`.
        -- If left unset, its default value is `true`, and it can be correctly overridden by project config files.
      },
    },
  },
})

-- LSP keymaps
vim.keymap.set('n', '<leader>er', vim.lsp.buf.rename, {})
vim.keymap.set('n', '<leader>nd', vim.lsp.buf.definition, {})
-- Show LSP diagnostic window
vim.keymap.set('n', '<leader>.', vim.diagnostic.open_float, {})
-- Show diagnostic message right in the code (virtual text)
vim.diagnostic.config({ virtual_text = true, }) 

-- Setup treesitter for AST folding
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "typescript", "tsx", "html", "lua", "markdown", "python" },
  highlight = { enable = true },
  indent = { enable = true },
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

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Enable ESLint
vim.lsp.enable('eslint')
-- Partially copied from here: https://github.com/neovim/nvim-lspconfig/blob/66fd02ad1c7ea31616d3ca678fa04e6d0b360824/lsp/eslint.lua#L43
local lsp = vim.lsp
local eslint_config_files = {
  '.eslintrc',
  '.eslintrc.js',
  '.eslintrc.cjs',
  '.eslintrc.yaml',
  '.eslintrc.yml',
  '.eslintrc.json',
  'eslint.config.js',
  'eslint.config.mjs',
  'eslint.config.cjs',
  'eslint.config.ts',
  'eslint.config.mts',
  'eslint.config.cts',
}
vim.lsp.config('eslint', {
 cmd = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
   workspace_required = true,
  root_dir = vim.fs.root(0, {'package.json', '.git'}),
--  on_attach = on_attach,
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspEslintFixAll', function()
      client:request_sync('workspace/executeCommand', {
        command = 'eslint.applyAllFixes',
        arguments = {
          {
            uri = vim.uri_from_bufnr(bufnr),
            version = lsp.util.buf_versions[bufnr],
          },
        },
      }, nil, bufnr)
    end, {})
  end,
  settings = {
    validate = 'on',
    ---@diagnostic disable-next-line: assign-type-mismatch
    packageManager = nil,
    useESLintClass = false,
    experimental = {
      useFlatConfig = false,
    },
    codeActionOnSave = {
      enable = false,
      mode = 'all',
    },
    format = true,
    quiet = false,
    onIgnoredFiles = 'off',
    rulesCustomizations = {},
    run = 'onType',
    problems = {
      shortenToSingleLine = false,
    },
    -- nodePath configures the directory in which the eslint server should start its node_modules resolution.
    -- This path is relative to the workspace folder (root dir) of the server instance.
    nodePath = '',
    -- use the workspace folder location or the file location (if no workspace folder is open) as the working directory
    workingDirectory = { mode = 'auto' },
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = 'separateLine',
      },
      showDocumentation = {
        enable = true,
      },
    },
  },
  before_init = function(_, config)
    -- The "workspaceFolder" is a VSCode concept. It limits how far the
    -- server will traverse the file system when locating the ESLint config
    -- file (e.g., .eslintrc).
    local root_dir = config.root_dir

    if root_dir then
      config.settings = config.settings or {}
      config.settings.workspaceFolder = {
        uri = root_dir,
        name = vim.fn.fnamemodify(root_dir, ':t'),
      }

      -- Support flat config files
      -- They contain 'config' in the file name
      local flat_config_files = vim.tbl_filter(function(file)
        return file:match('config')
      end, eslint_config_files)

      for _, file in ipairs(flat_config_files) do
        local found_files = vim.fn.globpath(root_dir, file, true, true)

        -- Filter out files inside node_modules
        local filtered_files = {}
        for _, found_file in ipairs(found_files) do
          if string.find(found_file, '[/\\]node_modules[/\\]') == nil then
            table.insert(filtered_files, found_file)
          end
        end

        if #filtered_files > 0 then
          config.settings.experimental = config.settings.experimental or {}
	-- Causes `The eslint library loaded from <eslint-path> doesn't export a FlatESLint class.` error (https://github.com/neovim/nvim-lspconfig/issues/4318)
	-- config.settings.experimental.useFlatConfig = true
          break
        end
      end

      -- Support Yarn2 (PnP) projects
      local pnp_cjs = root_dir .. '/.pnp.cjs'
      local pnp_js = root_dir .. '/.pnp.js'
      if type(config.cmd) == 'table' and (vim.uv.fs_stat(pnp_cjs) or vim.uv.fs_stat(pnp_js)) then
        config.cmd = vim.list_extend({ 'yarn', 'exec' }, config.cmd --[[@as table]])
      end
    end
  end,
  handlers = {
    ['eslint/openDoc'] = function(_, result)
      if result then
        vim.ui.open(result.url)
      end
      return {}
    end,
    ['eslint/confirmESLintExecution'] = function(_, result)
      if not result then
        return
      end
      return 4 -- approved
    end,
    ['eslint/probeFailed'] = function()
      vim.notify('[lspconfig] ESLint probe failed.', vim.log.levels.WARN)
      return {}
    end,
    ['eslint/noLibrary'] = function()
      vim.notify('[lspconfig] Unable to find ESLint library.', vim.log.levels.WARN)
      return {}
    end,
  },
  capabilities = capabilities,
})

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
--vim.opt.foldlevel = 3


function set_file_folds()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
    -- Fix folding of files opened via Telescope
    vim.cmd.normal("zx")
    vim.opt_local.foldlevel = 99;
  --   vim.opt_local.foldlevel = 99
  end


-- BufEnter ensures that treesitter finished loading
--vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
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

-- Run Prettier on :w
vim.api.nvim_create_autocmd({"BufWritePost"}, {
  pattern = { "*.tsx", "*.ts", "*.js", "*.jsx", "*.css", "*.scss" },
  callback = function()
  	vim.cmd('silent! PrettierCli --write ' .. vim.fn.expand('%:p'))
  	vim.cmd('silent! edit!')
	set_file_folds()
  end
})


-- Every wrapped line will continue visually indented (same amount of
-- space as the beginning of that line), thus preserving horizontal
-- blocks of text.
vim.o.breakindent = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
-- Helps to avoid "flickering/shifting" of this column
-- when error / sign appears / dissapears
vim.o.signcolumn = 'yes'

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Show which line your cursor is on (highlight)
vim.o.cursorline = true

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next({ keywords = { "TODO" } })
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev({ keywords = { "TODO" } })
end, { desc = "Previous todo comment" })

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
-- vim.cmd("highlight iCursor guifg=NONE guibg=#00FF00 gui=NONE") -- Insert mode

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

-- Close Quickfix window
vim.keymap.set('n', '<leader>q', function()
	vim.cmd('cclose')
end, { desc = 'Close Quickfix window' })

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
end, { desc = 'Copy Diagnostic window contents' })

