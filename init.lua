-- Set leader key to Space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("config.lazy")

-- Load .vimrc file
vim.cmd("runtime ./.vimrc")

require("config.theme")
require("config.search")
require("config.copy-paste")
require("config.lsp.typescript")
require("config.lsp.python")
require("config.lsp.eslint")
require("config.lsp.common")
require("config.indent-fold")
require("config.git")
require("config.debug")
require("config.navigation")

