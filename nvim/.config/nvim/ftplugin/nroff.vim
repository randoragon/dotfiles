" Preview for man pages
nnoremap <buffer> <Leader>m :write \| AsyncRun man -Thtml -l "%:p" >"$VIM_PREVIEW_HOME"/vim-preview.html && pkill -x -HUP surf<CR>
nnoremap <buffer> <Leader>p :AsyncRun setsid surf -- file://"$VIM_PREVIEW_HOME/vim-preview.html"<CR>
nnoremap <buffer> <Leader>P :AsyncRun setsid $TERMINAL -e man -l "%:p"<CR>
