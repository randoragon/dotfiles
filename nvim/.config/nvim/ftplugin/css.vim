set tw=80
set noexpandtab
set shiftwidth=4
set tabstop=4
set softtabstop=0
inoremap <buffer> <M-p> <Esc>/<,,><CR>"_cf>
inoremap <buffer> <M-n> <C-o>o

command LSPFileToggleCSS    lua require('lsp').toggle({
            \   name = 'vscode-css-languageserver',
            \   cmd  = {'vscode-css-languageserver', '--stdio'},
            \   settings = require('lsp.settings.vscode-css-languageserver'),
            \ })
command LSPProjectToggleCSS lua require('lsp').toggle({
            \   name = 'vscode-css-languageserver',
            \   cmd  = {'vscode-css-languageserver', '--stdio'},
            \   settings = require('lsp.settings.vscode-css-languageserver'),
            \ },
            \ {
            \  '.git',
            \  'index.html',
            \  'Makefile', 'makefile', 'GNUmakefile',
            \  'CMakeLists.txt'
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleCSS<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleCSS<CR>
