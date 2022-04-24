inoremap <buffer> <M-p> <Esc>/<,,><CR>"_cf>
set tw=80
inoremap <Leader>= <- 
nnoremap <Leader>m :write \| !R -q -f %<CR>
nnoremap <Leader>o :!xdg-open Rplots.pdf<CR><CR>
inoremap <buffer> <M-n> <C-o>o
inoremap <buffer> <Leader>r return()<Left>
inoremap <buffer> <Leader>i if () <,,><C-o>F)
inoremap <buffer> <Leader>e else 
inoremap <buffer> <Leader>o else if () <,,><C-o>F)
inoremap <buffer> <Leader>f for () <,,><C-o>F)
