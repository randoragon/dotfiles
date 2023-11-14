setl tw=80
setl noexpandtab
setl shiftwidth=2
setl tabstop=2
setl softtabstop=0

inoremap <buffer> <Leader>p <p></p><C-o>F<
inoremap <buffer> <Leader>1 <h1></h1><C-o>F<
inoremap <buffer> <Leader>2 <h2></h2><C-o>F<
inoremap <buffer> <Leader>3 <h3></h3><C-o>F<
inoremap <buffer> <Leader>4 <h4></h4><C-o>F<
inoremap <buffer> <Leader>5 <h5></h5><C-o>F<
inoremap <buffer> <Leader>6 <h6></h6><C-o>F<
inoremap <buffer> <Leader>d <div><CR></div><C-o>O
inoremap <buffer> <Leader>s <span><CR></span><C-o>O

inoremap <buffer> <Leader>a <a href=""><,,></a><C-o>F"
inoremap <buffer> <Leader>b <b></b><C-o>F<
inoremap <buffer> <Leader>i <i></i><C-o>F<
inoremap <buffer> <Leader>u <u></u><C-o>F<
inoremap <buffer> <Leader>^ <sup></sup><C-o>F<
inoremap <buffer> <Leader>_ <sub></sub><C-o>F<

inoremap <buffer> <Leader>S <script src=""></script><C-o>F"
inoremap <buffer> <Leader>.S <script><CR></script><C-o>O
inoremap <buffer> <Leader>I <img src="" alt="<,,>"><C-o>3F"
inoremap <buffer> <Leader>C <pre><CR><code><CR><CR></code><CR></pre><C-o>2k
inoremap <buffer> <M-CR> <br>

inoremap <buffer> <Leader>L <ul><CR></ul><C-o>O
inoremap <buffer> <Leader>.L <ol><CR></ol><C-o>O
inoremap <buffer> <Leader>o <li></li><C-o>F<
inoremap <buffer> <Leader>D <dl><CR></dl><C-o>O
inoremap <buffer> <Leader>O <dt></dt><CR><dd><,,></dd><Esc>k$F<i

inoremap <buffer> <Leader>tt <table><CR></table><C-o>O
inoremap <buffer> <Leader>tr <tr><CR></tr><C-o>O
inoremap <buffer> <Leader>th <th></th><C-o>F<
inoremap <buffer> <Leader>td <td></td><C-o>F<
inoremap <buffer> <Leader>tR rowspan=""<Left>
inoremap <buffer> <Leader>tC colspan=""<Left>

inoremap <buffer> <Leader>ff <form action=""><CR><Tab><,,><CR></form><Esc>2k$F"i
inoremap <buffer> <Leader>fi <input type="" name="<,,>"><C-o>3F"
inoremap <buffer> <Leader>fl <label for=""><,,></label><C-o>F"
inoremap <buffer> <Leader>fs <input type="submit" value="<,,>"><C-o>3F"

inoremap <buffer> <Leader>.i id=""<Left>
inoremap <buffer> <Leader>.c class=""<Left>
inoremap <buffer> <Leader>.s src=""<Left>

command LSPFileToggleVue    lua lsp_toggle({
            \   name = "vls",
            \   cmd  = {"vls"},
            \   settings = require("lsp.settings.vls"),
            \ })
command LSPProjectToggleVue lua lsp_toggle({
            \   name = "vls",
            \   cmd  = {"vls"},
            \   settings = require("lsp.settings.vls"),
            \ },
            \ {
            \  ".git",
            \  "tsconfig.json", "jsconfig.json", "package.json",
            \  "Makefile", "makefile", "GNUmakefile",
            \  "CMakeLists.txt"
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleVue<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleVue<CR>
