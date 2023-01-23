inoremap <buffer> <M-p> <Esc>/<,,><CR>"_cf>

inoremap <buffer> <M-n> <C-o>o
set tw=80
inoremap <buffer> <Leader>t static 
inoremap <buffer> <Leader>c const 
inoremap <buffer> <Leader>.c /*  */<Left><Left><Left>
inoremap <buffer> <Leader>s struct 
inoremap <buffer> <Leader>u unsigned 
inoremap <buffer> <Leader>z size_t 
inoremap <buffer> <Leader>.z sizeof()<Left>
inoremap <buffer> <Leader>.s switch () <,,><C-o>F)
inoremap <buffer> <Leader>r return 
inoremap <buffer> <Leader>i if () <,,><C-o>F)
inoremap <buffer> <Leader>e else 
inoremap <buffer> <Leader>o else if () <,,><C-o>F)
inoremap <buffer> <Leader>f for () <,,><C-o>F)
inoremap <buffer> <Leader>w while () <,,><C-o>F)
inoremap <buffer> <Leader>mm malloc()<Left>
inoremap <buffer> <Leader>mc calloc()<Left>
inoremap <buffer> <Leader>mr realloc()<Left>
inoremap <buffer> <Leader>mf free();<Left><Left>

command LSPFileToggleCPP    lua require('lsptools').toggle('clsp', {'ccls'})
command LSPProjectToggleCPP lua require('lsptools').toggle('clsp', {'ccls'},
            \ {
            \  '.git',
            \  'Makefile', 'makefile', 'GNUmakefile',
            \  'CMakeLists.txt'
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleCPP<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleCPP<CR>
