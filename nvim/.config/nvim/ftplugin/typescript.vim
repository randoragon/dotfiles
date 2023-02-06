set tw=80
set noexpandtab
set shiftwidth=2
set tabstop=2
set softtabstop=0

command LSPFileToggleTS    lua require('lsptools').toggle('tslsp', {'typescript-language-server', '--stdio'})
command LSPProjectToggleTS lua require('lsptools').toggle('tslsp', {'typescript-language-server', '--stdio'},
            \ {
            \  '.git',
            \  'tsconfig.json', 'jsconfig.json', 'package.json',
            \  'Makefile', 'makefile', 'GNUmakefile',
            \  'CMakeLists.txt'
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleTS<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleTS<CR>
