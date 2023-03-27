" Source general groff config
source ~/.config/nvim/ftplugin/groff.vim

" Preview
nnoremap <buffer> <Leader>m :write \| AsyncRun pdfmom -kept "%:p" >"$VIM_PREVIEW_HOME/vim-preview.pdf"<CR>
