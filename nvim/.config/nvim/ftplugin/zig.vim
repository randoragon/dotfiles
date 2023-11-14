setl tw=80

inoremap <buffer> <Leader>t static 
inoremap <buffer> <Leader>c const 
inoremap <buffer> <Leader>.c /*  */<Left><Left><Left>
inoremap <buffer> <Leader>s struct 
inoremap <buffer> <Leader>.s switch () <,,><C-o>F)
inoremap <buffer> <Leader>r return 
inoremap <buffer> <Leader>i if () <,,><C-o>F)
inoremap <buffer> <Leader>e else 
inoremap <buffer> <Leader>o else if () <,,><C-o>F)
inoremap <buffer> <Leader>f for () <,,><C-o>F)
inoremap <buffer> <Leader>w while () <,,><C-o>F)

command LSPFileToggleZig    lua lsp_toggle("ziglsp", {"zls"})
            \   name = "ziglsp",
            \   cmd  = {"zls"},
            \   settings = require("lsp.settings.zls"),
            \ })
command LSPProjectToggleZig lua lsp_toggle("ziglsp", {"zls"},
            \ {
            \  ".git",
            \  "build.zig",
            \  "Makefile", "makefile", "GNUmakefile",
            \  "CMakeLists.txt"
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleZig<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleZig<CR>
