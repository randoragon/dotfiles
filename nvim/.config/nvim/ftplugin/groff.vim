" Smart trick for jumping to/out of input field
inoremap <buffer> <C-L> <Esc>/<,,><CR>"_cf>

" General groff macros
inoremap <buffer> <Leader>ib \f[B]\f[P]<,,><C-O>F\
inoremap <buffer> <Leader>ii \f[I]\f[P]<,,><C-O>F\
inoremap <buffer> <Leader>ic \f[C]\f[P]<,,><C-O>F\
inoremap <buffer> <Leader>ih \h''<,,><C-O>4h
inoremap <buffer> <Leader>iv \v''<,,><C-O>4h
inoremap <buffer> <Leader>iw \w''<,,><C-O>4h
inoremap <buffer> <Leader>ir \s''<,,><C-O>4h

" Preprocessor macros
inoremap <buffer> <Leader>ie <C-O>O.EQ<Esc>jo.EN<C-O>k
inoremap <buffer> <Leader>it <C-O>O.TS<Esc>jo.TE<C-O>k

" mom macros
inoremap <buffer> <Leader>i] \*[]<,,><C-O>5h
inoremap <buffer> <Leader>i^ \*[SUP]\*[SUPX]<,,><C-O>F\
