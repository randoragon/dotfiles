" Smart trick for jumping to/out of input field
inoremap <buffer> <C-L> <Esc>/<,,><CR>"_cf>

" Inline font type
inoremap <buffer> <Leader>ii \fI\fP<,,><C-O>F\
inoremap <buffer> <Leader>ib \fB\fP<,,><C-O>F\
inoremap <buffer> <Leader>i1 \f1\fP<,,><C-O>F\
inoremap <buffer> <Leader>i2 \f2\fP<,,><C-O>F\
inoremap <buffer> <Leader>i3 \f3\fP<,,><C-O>F\
inoremap <buffer> <Leader>i4 \f4\fP<,,><C-O>F\
inoremap <buffer> <Leader>i5 \f5\fP<,,><C-O>F\
inoremap <buffer> <Leader>i6 \f6\fP<,,><C-O>F\
inoremap <buffer> <Leader>i7 \f7\fP<,,><C-O>F\
inoremap <buffer> <Leader>i8 \f8\fP<,,><C-O>F\
inoremap <buffer> <Leader>i9 \f9\fP<,,><C-O>F\
inoremap <buffer> <Leader>ih \h''<,,><C-O>F'
inoremap <buffer> <Leader>iv \v''<,,><C-O>F'
inoremap <buffer> <Leader>iw \w''<,,><C-O>F'
inoremap <buffer> <Leader>ir \s''<,,><C-O>F'

" Preprocessor macros
inoremap <buffer> <Leader>ie <C-O>O.EQ<Esc>jo.EN<C-O>k
inoremap <buffer> <Leader>it <C-O>O.TS<Esc>jo.TE<C-O>k
