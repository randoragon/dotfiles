" Smart trick for jumping to/out of input field
inoremap <buffer> <C-L> <Esc>/<,,><CR>"_cf>

" General groff macros
inoremap <buffer> <Leader>ib \fB\fP<,,><C-O>F\
inoremap <buffer> <Leader>ii \fI\fP<,,><C-O>F\
inoremap <buffer> <Leader>ic \fC\fP<,,><C-O>F\
inoremap <buffer> <Leader>ih \h''<,,><C-O>F'
inoremap <buffer> <Leader>iv \v''<,,><C-O>F'
inoremap <buffer> <Leader>iw \w''<,,><C-O>F'
inoremap <buffer> <Leader>ir \s''<,,><C-O>F'
" Preprocessor macros
inoremap <buffer> <Leader>ie <C-O>O.EQ<Esc>jo.EN<C-O>k
inoremap <buffer> <Leader>it <C-O>O.TS<Esc>jo.TE<C-O>k
