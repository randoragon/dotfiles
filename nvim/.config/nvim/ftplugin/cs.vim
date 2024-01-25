setl tw=80

inoremap <buffer> <M-n> <C-o>o
inoremap <buffer> <Leader>t static 
inoremap <buffer> <Leader>c const 
inoremap <buffer> <Leader>.c /*  */<Left><Left><Left>
inoremap <buffer> <Leader>s struct 
inoremap <buffer> <Leader>.z sizeof()<Left>
inoremap <buffer> <Leader>.s switch () <,,><C-o>F)
inoremap <buffer> <Leader>r return 
inoremap <buffer> <Leader>i if () <,,><C-o>F)
inoremap <buffer> <Leader>e else 
inoremap <buffer> <Leader>o else if () <,,><C-o>F)
inoremap <buffer> <Leader>f for () <,,><C-o>F)
inoremap <buffer> <Leader>w while () <,,><C-o>F)

command LSPFileToggleCSharp    lua lsp_toggle({
            \   name = "omnisharp",
            \   cmd  = {"omnisharp", "-lsp"},
            \   settings = require("lsp.settings.omnisharp"),
            \ })
command LSPProjectToggleCSharp lua lsp_toggle({
            \   name = "omnisharp",
            \   cmd  = {"omnisharp", "-lsp"},
            \   settings = require("lsp.settings.omnisharp"),
            \ },
            \ {
            \  ".git",
            \  "*.sln", "*.csproj",
            \  "omnisharp.json", "function.json",
            \  "Makefile", "makefile", "GNUmakefile",
            \  "CMakeLists.txt"
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleCSharp<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleCSharp<CR>
