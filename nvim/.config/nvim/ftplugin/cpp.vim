setl foldmethod=indent

inoremap <buffer> <Leader>I #include 
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

command LSPFileToggleCPP    lua lsp_toggle({
            \   name = "clangd",
            \   cmd  = {"clangd"},
            \   settings = require("lsp.settings.clangd"),
            \ })
command LSPProjectToggleCPP lua lsp_toggle({
            \   name = "clangd",
            \   cmd  = {"clangd"},
            \   settings = require("lsp.settings.clangd"),
            \ },
            \ {
            \  ".git",
            \  "Makefile", "makefile", "GNUmakefile",
            \  "CMakeLists.txt",
            \  ".clangd",
            \  ".clang-tidy",
            \  ".clang-format",
            \  "compile_commands.json",
            \  "compile_flags.txt",
            \  "configure.ac"
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleCPP<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleCPP<CR>
