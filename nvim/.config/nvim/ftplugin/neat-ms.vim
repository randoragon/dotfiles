" Source general groff config
source ~/.config/nvim/ftplugin/groff.vim

" Embed screenshots
nnoremap <buffer> <Leader>is :call sshot#ImportScreenshot(function('sshot#NeatRoffScreenshot'), '.pdf')<CR>
