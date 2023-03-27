" Preview
nnoremap <buffer> <Leader>m :write \| AsyncRun (printf '\%s\n' "$HTML_MD_STYLE" && md2html --github "%:p") > "$VIM_PREVIEW_HOME/vim-preview.html" && pkill -HUP surf<CR>
nnoremap <buffer> <Leader>p :AsyncRun setsid surf -- file://"$VIM_PREVIEW_HOME/vim-preview.html"<CR>
nnoremap <buffer> <Leader>P :AsyncRun xdg-open file://"$VIM_PREVIEW_HOME/vim-preview.html"<CR>

" Embed screenshots
nnoremap <buffer> <Leader>is :call sshot#ImportScreenshot(function('sshot#MarkdownScreenshot'), '.png')<CR>
