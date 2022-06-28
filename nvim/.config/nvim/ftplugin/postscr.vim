" Preview
nnoremap <buffer> <Leader>m :write \| AsyncRun ps2pdf "%:p" "${XDG_CACHE_HOME:-~/.cache}/vim-preview.pdf"<CR>
nnoremap <buffer> <Leader>p :AsyncRun setsid xdg-open "${XDG_CACHE_HOME:-~/.cache}/vim-preview.pdf"<CR>
