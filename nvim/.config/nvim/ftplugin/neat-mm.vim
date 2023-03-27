" Source general groff config
source ~/.config/nvim/ftplugin/groff.vim

" Preview
nnoremap <buffer> <Leader>m :write \| AsyncRun ntmake "%:p" -mm > "$VIM_PREVIEW_HOME/vim-preview.pdf"<CR>

" Embed screenshots
nnoremap <buffer> <Leader>is :call sshot#ImportScreenshot(function('sshot#NeatRoffScreenshot'), '.pdf')<CR>

" Insert URI
inoremap <buffer> <Leader>il \*[URL ]<,,><C-O>F]
