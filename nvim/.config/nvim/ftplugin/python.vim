setl foldmethod=indent

nnoremap <buffer> <Leader>m :write \| split \| terminal python3 -i %<CR>
nnoremap <buffer> <Leader>.m :write \| split \| terminal ipython -i %<CR>

inoremap <buffer> <Leader>I import 
inoremap <buffer> <Leader>r return 
inoremap <buffer> <Leader>i if 
inoremap <buffer> <Leader>e else:
inoremap <buffer> <Leader>o elif 
inoremap <buffer> <Leader>f for 
inoremap <buffer> <Leader>w while 
inoremap <buffer> <Leader>R range()<Left>
inoremap <buffer> <Leader>F filter(, <,,>)<C-o>F(<Right>
inoremap <buffer> <Leader>M map(, <,,>)<C-o>F(<Right>
inoremap <buffer> <Leader>c class 
inoremap <buffer> <Leader>s split()<Left>

command LSPFileTogglePy    lua lsp_toggle({
            \   name = "pylsp",
            \   cmd  = {"pylsp"},
            \   settings = require("lsp.settings.pylsp"),
            \ })
command LSPProjectTogglePy lua lsp_toggle({
            \   name = "pylsp",
            \   cmd  = {"pylsp"},
            \   settings = require("lsp.settings.pylsp"),
            \ },
            \ {
            \  ".git",
            \  "setup.py",
            \  "Makefile", "makefile", "GNUmakefile",
            \  "CMakeLists.txt"
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileTogglePy<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectTogglePy<CR>
