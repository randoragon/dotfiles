nnoremap <buffer> <Leader>m :write \| !R -q -f %<CR>
nnoremap <buffer> <Leader>o :!xdg-open Rplots.pdf<CR><CR>

inoremap <buffer> <Leader>= <- 
inoremap <buffer> <Leader>r return()<Left>
inoremap <buffer> <Leader>i if () <,,><C-o>F)
inoremap <buffer> <Leader>e else 
inoremap <buffer> <Leader>o else if () <,,><C-o>F)
inoremap <buffer> <Leader>f for () <,,><C-o>F)
