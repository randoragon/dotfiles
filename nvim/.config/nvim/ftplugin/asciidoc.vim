setl tw=80

" Preview
nnoremap <buffer> <Leader>m :write \| AsyncRun echo $ASCIIDOCTOR_OPTS -a 'imagesdir=%:p:h' -o "$VIM_PREVIEW_HOME/vim-preview.html" -- "%:p" \| xargs asciidoctor && pkill -x -HUP surf<CR>
nnoremap <buffer> <Leader>p :AsyncRun setsid surf -S -- file://"$VIM_PREVIEW_HOME/vim-preview.html"<CR>
nnoremap <buffer> <Leader>P :AsyncRun xdg-open file://"$VIM_PREVIEW_HOME/vim-preview.html"<CR>

" Embed screenshots
nnoremap <buffer> <Leader>is :call sshot#ImportScreenshot(function('sshot#AsciidocScreenshot'), '.png')<CR>

inoremap <buffer> <Leader>ul [.underline]##<Left>
inoremap <buffer> <Leader>ol [.overline]##<Left>
inoremap <buffer> <Leader>lt [.line-through]##<Left>

inoremap <buffer> <Leader>h [horizontal]
inoremap <buffer> <Leader>gg [gnuplot, target=, align=center]<CR>--<CR>--<C-o>Oset title<CR>set xlabel<CR>set ylabel<CR>set key off<CR>set autoscale<CR>set samples 200<CR>plot <,,><Esc>8k0f=:call EnterFileMode("gnuplot")<CR>a
inoremap <buffer> <Leader>gd [graphviz, target=, align=center]<CR>--<CR>--<C-o>Odigraph {<CR>}<C-o>O<Tab>rankdir=LR;<CR><,,><Esc>4k0f=:call EnterFileMode("dot")<CR>a
inoremap <buffer> <Leader>gm [msc, target=, align=center]<CR>--<CR>--<C-o>Omsc {<CR>}<C-o>O<Tab>hscale="1";<CR><,,><Esc>4k0f=:call EnterFileMode("mscgen")<CR>a
inoremap <buffer> <Leader>.s stem:[]<Left>
inoremap <buffer> <Leader>.S [stem]<CR>++++<CR>++++<C-o>O

inoremap <buffer> <Leader>sb ****<CR>****<C-o>O
inoremap <buffer> <Leader>eb ====<CR>====<C-o>O
inoremap <buffer> <Leader>qb ----<CR>----<C-o>O
inoremap <buffer> <Leader>ob --<CR>--<C-o>O
inoremap <buffer> <Leader>pb ++++<CR>++++<C-o>O
inoremap <buffer> <Leader>tt [.left, cols="", width=100, frame=all, grid=all, stripes=none]<CR>\|===<CR><,,><CR>\|===<Esc>3k0f"a
inoremap <buffer> <Leader>t, [.left, cols="", width=100, frame=sides, grid=cols, stripes=none]<CR>,===<CR><,,><CR>,===<Esc>3k0f"a
inoremap <buffer> <Leader>t: [.left, cols="", width=100, frame=sides, grid=cols, stripes=none]<CR>:===<CR><,,><CR>:===<Esc>3k0f"a
