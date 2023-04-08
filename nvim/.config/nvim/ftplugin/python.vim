inoremap <buffer> <M-p> <Esc>/<,,><CR>"_cf>

nnoremap <buffer> <Leader>m :write \| split \| terminal python3 -i %<CR>
inoremap <buffer> <M-n> <C-o>o
set tw=80
inoremap <buffer> <Leader>r return 
inoremap <buffer> <Leader>i if 
inoremap <buffer> <Leader>e else:
inoremap <buffer> <Leader>o elif 
inoremap <buffer> <Leader>f for 
inoremap <buffer> <Leader>w while 
inoremap <buffer> <Leader>.r range()<Left>
inoremap <buffer> <Leader>.f filter(, <,,>)<C-o>F(<Right>
inoremap <buffer> <Leader>m map(, <,,>)<C-o>F(<Right>
inoremap <buffer> <Leader>s split()<Left>

command LSPFileTogglePy    lua require('lsp').toggle({
            \   name = 'pylsp',
            \   cmd  = {'pylsp'},
            \   settings = require('lsp.settings.pylsp'),
            \ })
command LSPProjectTogglePy lua require('lsp').toggle({
            \   name = 'pylsp',
            \   cmd  = {'pylsp'},
            \   settings = require('lsp.settings.pylsp'),
            \ },
            \ {
            \  '.git',
            \  'setup.py',
            \  'Makefile', 'makefile', 'GNUmakefile',
            \  'CMakeLists.txt'
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileTogglePy<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectTogglePy<CR>
