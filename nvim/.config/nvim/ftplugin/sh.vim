setl expandtab shiftwidth=4 tabstop=4 softtabstop=4

nnoremap <buffer> <Leader>m :write \| split \| terminal sh -i %<CR>

inoremap <buffer> <Leader>r return 
inoremap <buffer> <Leader>i if 
inoremap <buffer> <Leader>T then<CR>fi<Esc>O
inoremap <buffer> <Leader>e else
inoremap <buffer> <Leader>o elif 
inoremap <buffer> <Leader>f for 
inoremap <buffer> <Leader>w while 
inoremap <buffer> <Leader>R read -r 
inoremap <buffer> <Leader>p printf 
inoremap <buffer> <Leader>x exit

command LSPFileToggleBash    lua lsp_toggle({
            \   name = "bash-language-server",
            \   cmd  = {"bash-language-server", "start"},
            \   settings = require("lsp.settings.bash-language-server"),
            \ })
command LSPProjectToggleBash lua lsp_toggle({
            \   name = "bash-language-server",
            \   cmd  = {"bash-language-server", "start"},
            \   settings = require("lsp.settings.bash-language-server"),
            \ },
            \ {
            \  ".git",
            \  "Makefile", "makefile", "GNUmakefile",
            \  "CMakeLists.txt"
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleBash<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleBash<CR>
