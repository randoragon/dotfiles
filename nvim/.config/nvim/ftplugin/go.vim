inoremap <buffer> <M-p> <Esc>/<,,><CR>"_cf>

inoremap <buffer> <M-n> <C-o>o
set tw=80
inoremap <buffer> <Leader>t static 
inoremap <buffer> <Leader>c const 
inoremap <buffer> <Leader>.c /*  */<Left><Left><Left>
inoremap <buffer> <Leader>s struct 
inoremap <buffer> <Leader>u unsigned 
inoremap <buffer> <Leader>.s switch () <,,><C-o>F)
inoremap <buffer> <Leader>r return 
inoremap <buffer> <Leader>i if () <,,><C-o>F)
inoremap <buffer> <Leader>e else 
inoremap <buffer> <Leader>o else if () <,,><C-o>F)
inoremap <buffer> <Leader>f for () <,,><C-o>F)
inoremap <buffer> <Leader>w while () <,,><C-o>F)

command LSPFileToggleC    lua require('lsptools').toggle('golsp', {'gopls'})
command LSPProjectToggleC lua require('lsptools').toggle('golsp', {'gopls'},
            \ {
            \  '.git',
            \  'go.mod', 'go.sum', 'main.go',
            \  'Makefile', 'makefile', 'GNUmakefile',
            \  'CMakeLists.txt'
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleC<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleC<CR>
