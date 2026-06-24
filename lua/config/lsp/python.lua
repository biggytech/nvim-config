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
	autoImportCompletions = true
      },
    },
  },
})
