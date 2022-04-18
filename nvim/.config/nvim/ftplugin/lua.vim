inoremap <buffer> <M-p> <Esc>/<,,><CR>"_cf>

nnoremap <buffer> <Leader>m :write \| split \| terminal lua -i %<CR>
nnoremap <buffer> <C-]> :ALEGoToDefinition<CR>
inoremap <buffer> <M-n> <C-o>o
set tw=80
inoremap <buffer> <Leader>l local 
inoremap <buffer> <Leader>r return 
inoremap <buffer> <Leader>i if 
inoremap <buffer> <Leader>e else:
inoremap <buffer> <Leader>o elseif 
inoremap <buffer> <Leader>f for 
inoremap <buffer> <Leader>w while 
inoremap <buffer> <Leader>F function 
