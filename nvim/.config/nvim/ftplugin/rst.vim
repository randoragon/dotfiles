" Preview
nnoremap <buffer> <Leader>m :write \| AsyncRun rst2html "%" > "${XDG_CACHE_HOME:-~/.cache}/vim-preview.html" && pkill -HUP surf<CR>
nnoremap <buffer> <Leader>p :AsyncRun setsid surf -- file://"${XDG_CACHE_HOME:-~/.cache}/vim-preview.html"<CR>
nnoremap <buffer> <Leader>P :AsyncRun xdg-open file://"${XDG_CACHE_HOME:-~/.cache}/vim-preview.html"<CR>
