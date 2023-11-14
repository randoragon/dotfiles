setl shiftwidth=2 tabstop=2

command LSPFileToggleJS    lua lsp_toggle({
            \   name = "typescript-language-server",
            \   cmd  = {"typescript-language-server", "--stdio"},
            \   settings = require("lsp.settings.typescript-language-server"),
            \ })
command LSPProjectToggleJS lua lsp_toggle({
            \   name = "typescript-language-server",
            \   cmd  = {"typescript-language-server", "--stdio"},
            \   settings = require("lsp.settings.typescript-language-server"),
            \ },
            \ {
            \  ".git",
            \  "tsconfig.json", "jsconfig.json", "package.json",
            \  "Makefile", "makefile", "GNUmakefile",
            \  "CMakeLists.txt"
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleJS<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleJS<CR>
