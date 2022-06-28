" Preview
nnoremap <buffer> <Leader>m :write \| AsyncRun asciidoctor -a 'imagesdir=%:p:h' -o "${XDG_CACHE_HOME:-~/.cache}/vim-preview.html" -- "%:p" && pkill -HUP surf<CR>
nnoremap <buffer> <Leader>p :AsyncRun setsid surf -- file://"${XDG_CACHE_HOME:-~/.cache}/vim-preview.html"<CR>

" Embed screenshots
nnoremap <buffer> <Leader>is :call sshot#ImportScreenshot(function('sshot#AsciidocScreenshot'), '.png')<CR>
