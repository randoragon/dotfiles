setl tw=80
setl noexpandtab
setl shiftwidth=2
setl tabstop=2
setl softtabstop=0

command LSPFileToggleTS    lua lsp_toggle({
            \   name = "typescript-language-server",
            \   cmd  = {"typescript-language-server", "--stdio"},
            \   settings = require("lsp.settings.typescript-language-server"),
            \ })
command LSPProjectToggleTS lua lsp_toggle({
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
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleTS<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleTS<CR>
