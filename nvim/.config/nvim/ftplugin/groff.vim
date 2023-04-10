" Preview
nnoremap <buffer> <Leader>m :write \| AsyncRun groff -kept -Tpdf "%:p" > "$VIM_PREVIEW_HOME/vim-preview.pdf"<CR>
nnoremap <buffer> <Leader>p :AsyncRun setsid xdg-open "$VIM_PREVIEW_HOME/vim-preview.pdf"<CR>

" Inline font type
inoremap <buffer> <Leader>ii \fI\fP<,,><C-O>F\
inoremap <buffer> <Leader>ib \fB\fP<,,><C-O>F\
inoremap <buffer> <Leader>iI \f(BI\fP<,,><C-O>F\
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

" Surround blocks
inoremap <buffer> <Leader>ie <C-O>O.EQ<Esc>jo.EN<C-O>k
inoremap <buffer> <Leader>it <C-O>O.TS<Esc>jo.TE<C-O>k
inoremap <buffer> <Leader>ik <C-O>O.KS<Esc>jo.KE<C-O>k
inoremap <buffer> <Leader>id <C-O>O.DS<Esc>jo.DE<C-O>k
inoremap <buffer> <Leader>ip <C-O>O.DS<Esc>jo.DE<C-O>k

" Disable auto-pairs
let b:autopairs_enabled = 0
