" Preview
nnoremap <buffer> <Leader>m :write \| AsyncRun rst2html "%" > "$VIM_PREVIEW_HOME/vim-preview.html" && pkill -x -HUP surf<CR>
nnoremap <buffer> <Leader>p :AsyncRun setsid surf -- file://"$VIM_PREVIEW_HOME/vim-preview.html"<CR>
nnoremap <buffer> <Leader>P :AsyncRun xdg-open file://"$VIM_PREVIEW_HOME/vim-preview.html"<CR>
