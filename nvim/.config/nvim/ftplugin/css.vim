set tw=80
set noexpandtab
set shiftwidth=4
set tabstop=4
set softtabstop=0
inoremap <buffer> <M-p> <Esc>/<,,><CR>"_cf>
inoremap <buffer> <M-n> <C-o>o

command LSPFileToggleCSS    lua require('lsptools').toggle('csslsp', {'vscode-css-languageserver', '--stdio'})
command LSPProjectToggleCSS lua require('lsptools').toggle('csslsp', {'vscode-css-languageserver', '--stdio'},
            \ {
            \  '.git',
            \  'index.html',
            \  'Makefile', 'makefile', 'GNUmakefile',
            \  'CMakeLists.txt'
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleCSS<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleCSS<CR>
