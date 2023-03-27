" Preview
nnoremap <buffer> <Leader>m :write \| AsyncRun ps2pdf "%:p" "$VIM_PREVIEW_HOME/vim-preview.pdf"<CR>
nnoremap <buffer> <Leader>p :AsyncRun setsid xdg-open "$VIM_PREVIEW_HOME/vim-preview.pdf"<CR>
