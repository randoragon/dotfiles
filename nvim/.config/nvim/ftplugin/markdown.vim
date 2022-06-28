" Preview
nnoremap <buffer> <Leader>m :write \| AsyncRun (printf '\%s\n' "$HTML_MD_STYLE" && md2html --github "%:p") > "${XDG_CACHE_HOME:-~/.cache}/vim-preview.html" && pkill -HUP surf<CR>
nnoremap <buffer> <Leader>p :AsyncRun setsid surf -- file://"${XDG_CACHE_HOME:-~/.cache}/vim-preview.html"<CR>

" Embed screenshots
nnoremap <buffer> <Leader>is :call sshot#ImportScreenshot(function('sshot#MarkdownScreenshot'), '.png')<CR>
