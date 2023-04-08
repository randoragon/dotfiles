set tw=80
set noexpandtab
set shiftwidth=2
set tabstop=2
set softtabstop=0

command LSPFileToggleTS    lua require('lsp').toggle({
            \   name = 'typescript-language-server',
            \   cmd  = {'typescript-language-server', '--stdio'},
            \   settings = require('lsp.settings.typescript-language-server'),
            \ })
command LSPProjectToggleTS lua require('lsp').toggle({
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
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleTS<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleTS<CR>
