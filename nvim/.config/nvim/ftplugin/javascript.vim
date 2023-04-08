set tw=80
set noexpandtab
set shiftwidth=2
set tabstop=2
set softtabstop=0

command LSPFileToggleJS    lua require('lsp').toggle({
            \   name = 'typescript-language-server',
            \   cmd  = {'typescript-language-server', '--stdio'},
            \   settings = require('lsp.settings.typescript-language-server'),
            \ })
command LSPProjectToggleJS lua require('lsp').toggle({
            \   name = 'typescript-language-server',
            \   cmd  = {'typescript-language-server', '--stdio'},
            \   settings = require('lsp.settings.typescript-language-server'),
            \ },
            \ {
            \  '.git',
            \  'tsconfig.json', 'jsconfig.json', 'package.json',
            \  'Makefile', 'makefile', 'GNUmakefile',
            \  'CMakeLists.txt'
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleJS<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleJS<CR>
