" Source general groff config
source ~/.config/nvim/ftplugin/groff.vim

" Preview
nnoremap <buffer> <Leader>m :write \| AsyncRun pdfmom -kept "%:p" > "${XDG_CACHE_HOME:-~/.cache}/vim-preview.pdf"<CR>
