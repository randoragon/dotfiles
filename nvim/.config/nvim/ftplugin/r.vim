nnoremap <Leader>m :write \| !R -q -f %<CR>
nnoremap <Leader>o :!xdg-open Rplots.pdf<CR><CR>

inoremap <Leader>= <- 
inoremap <buffer> <Leader>r return()<Left>
inoremap <buffer> <Leader>i if () <,,><C-o>F)
inoremap <buffer> <Leader>e else 
inoremap <buffer> <Leader>o else if () <,,><C-o>F)
inoremap <buffer> <Leader>f for () <,,><C-o>F)
