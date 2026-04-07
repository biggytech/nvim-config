## How to install
Just clone into `~/.config/nvim` and run NeoVim.

## Dependencies
1. `npm i -g typescript-language-server` for TypeScript LSP
2. `npm install --global vscode-langservers-extracted@4.8.0` for ESLint
3.`Nerd Font` for autocompletion window (download [here](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/NerdFontsSymbolsOnly.zip))
4.`Nerd Font` patched for LuaLine (download and install any font from [here](https://www.nerdfonts.com/font-downloads)) and set it as your terminal font:
    - Ubuntu (Gnome Terminal): Terminal -> Preferences -> Select your profile -> Custom Font -> Select the Nerd font -> Save & Restart terminal
5. `ripgrep`, or similar alternative, is a required dependency for the Telescope. Visit [here](https://github.com/BurntSushi/ripgrep#installation) for in
stallation instructions.

## Features
- Light Color Theme
- Search in Files and by Files
- Autocompletion

### LSP
- TypeScript
- ESLint
