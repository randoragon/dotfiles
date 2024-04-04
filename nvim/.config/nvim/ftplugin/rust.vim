inoremap <buffer> <Leader>t static 
inoremap <buffer> <Leader>c const 
inoremap <buffer> <Leader>.c /*  */<Left><Left><Left>
inoremap <buffer> <Leader>s struct 
inoremap <buffer> <Leader>m match 
inoremap <buffer> <Leader>r return 
inoremap <buffer> <Leader>i if 
inoremap <buffer> <Leader>e else 
inoremap <buffer> <Leader>o else if 
inoremap <buffer> <Leader>f for 
inoremap <buffer> <Leader>w while 
inoremap <buffer> <Leader>p println!("")<,,><C-o>F"
inoremap <buffer> <Leader>a assert!()<,,><C-o>F)
inoremap <buffer> <Leader>.a debug_assert!()<,,><C-o>F)

command LSPFileToggleRust    lua lsp_toggle({
            \   name = "rust-analyzer",
            \   cmd  = {"rust-analyzer"},
            \   settings = require("lsp.settings.rust_analyzer"),
            \ })
command LSPProjectToggleRust lua lsp_toggle({
            \   name = "rust-analyzer",
            \   cmd  = {"rust-analyzer"},
            \   settings = require("lsp.settings.rust_analyzer"),
            \ },
            \ {
            \  ".git",
            \  "Cargo.toml", "Cargo.lock"
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleRust<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleRust<CR>
