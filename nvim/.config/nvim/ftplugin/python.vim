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
inoremap <buffer> <Leader>p print()<Left>
inoremap <buffer> <Leader>a assert 

command LSPFileTogglePy    lua lsp_toggle({
            \   name = "pyright",
            \   cmd  = {"pyright-langserver", "--stdio"},
            \   settings = require("lsp.settings.pyright"),
            \ })
command LSPProjectTogglePy lua lsp_toggle({
            \   name = "pyright",
            \   cmd  = {"pyright-langserver", "--stdio"},
            \   settings = require("lsp.settings.pyright"),
            \ },
            \ {
            \  ".git",
            \  "setup.py",
            \  "pyproject.toml",
            \  "setup.cfg",
            \  "requirements.txt",
            \  "Pipfile",
            \  "pyrightconfig.json",
            \  "Makefile", "makefile", "GNUmakefile",
            \  "CMakeLists.txt"
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileTogglePy<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectTogglePy<CR>
