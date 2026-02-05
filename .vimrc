" Show a few lines of context around the cursor. Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Map Ctrl+Space to Enter/Exit Insert mode
" THIS DOESN'T WORK ON WINDOWS POWERSHELL
nnoremap <C-Space> i
inoremap <C-Space> <Esc>
nnoremap <C-@> i
inoremap <C-@> <Esc>

" Support external clipboard
" Linux
set clipboard+=unnamedplus
" MacOS and Windows
set clipboard+=unnamed

" Show both relative & usual line numbers
set number relativenumber

" Highlight Syntax
syntax on

" Run Prettier on :w
augroup Prettier
  au!
  " set foldlevel=99 is to fix Prettier truncating file when code folded
  au BufWritePre *.tsx,*.ts,*.js,*.jsx,*.css,*.scss set foldlevel=99 | Prettier | set foldlevel=3
augroup END

" This automatically folds files that you open,
" based on indent, for everything indented for more than 1 level.
set foldmethod=syntax
set foldlevel=3

let g:javaScript_fold=1 "activate folding by JS syntax
augroup jsFolds
    autocmd!
    autocmd FileType javascript,typescript,json syntax region braceFold start="{" end="}" transparent fold
    autocmd FileType javascript,typescript,json syntax sync fromstart
    autocmd FileType javascript,typescript,json set foldmethod=syntax
augroup end

" Use <Enter> in Normal mode to add a blank line below current
map <Enter> o<ESC>
" Use <S-Enter> in Normal mode to add a blank line above current
map <S-Enter> O<ESC>
