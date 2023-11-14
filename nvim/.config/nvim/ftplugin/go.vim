inoremap <buffer> <Leader>t static 
inoremap <buffer> <Leader>c const 
inoremap <buffer> <Leader>d defer 
inoremap <buffer> <Leader>.c /*  */<Left><Left><Left>
inoremap <buffer> <Leader>s struct 
inoremap <buffer> <Leader>u unsigned 
inoremap <buffer> <Leader>.s switch 
inoremap <buffer> <Leader>r return 
inoremap <buffer> <Leader>i if 
inoremap <buffer> <Leader>e else 
inoremap <buffer> <Leader>E if err != nil {}<Left><CR>
inoremap <buffer> <Leader>o else if 
inoremap <buffer> <Leader>f for 

command LSPFileToggleGo    lua lsp_toggle({
            \   name = "gopls",
            \   cmd  = {"gopls"},
            \   settings = require("lsp.settings.gopls"),
            \ })
command LSPProjectToggleGo lua lsp_toggle({
            \   name = "gopls",
            \   cmd  = {"gopls"},
            \   settings = require("lsp.settings.gopls"),
            \ },
            \ {
            \  ".git",
            \  "go.mod", "go.sum", "main.go",
            \  "Makefile", "makefile", "GNUmakefile",
            \  "CMakeLists.txt"
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleGo<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleGo<CR>
