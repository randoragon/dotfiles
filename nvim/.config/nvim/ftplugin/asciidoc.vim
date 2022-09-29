set tw=80
inoremap <buffer> <M-p> <Esc>/<,,><CR>"_cf>

" Preview
nnoremap <buffer> <Leader>m :write \| AsyncRun asciidoctor $ASCIIDOCTOR_OPTS -a 'imagesdir=%:p:h' -o "${XDG_CACHE_HOME:-~/.cache}/vim-preview.html" -- "%:p" && pkill -HUP surf<CR>
nnoremap <buffer> <Leader>p :AsyncRun setsid surf -S -- file://"${XDG_CACHE_HOME:-~/.cache}/vim-preview.html"<CR>

" Embed screenshots
nnoremap <buffer> <Leader>is :call sshot#ImportScreenshot(function('sshot#AsciidocScreenshot'), '.png')<CR>

inoremap <buffer> <Leader>ul [.underline]##<Left>
inoremap <buffer> <Leader>ol [.overline]##<Left>
inoremap <buffer> <Leader>lt [.line-through]##<Left>

inoremap <buffer> <Leader>h [horizontal]
inoremap <buffer> <Leader>gg [graphviz, target=, align=center]<CR>--<CR>--<C-o>Ograph {<CR>}<C-o>O<Tab>rankdir=LR;<CR><,,><Esc>4k0f=:call EnterFileMode("dot")<CR>a
inoremap <buffer> <Leader>gd [graphviz, target=, align=center]<CR>--<CR>--<C-o>Odigraph {<CR>}<C-o>O<Tab>rankdir=LR;<CR><,,><Esc>4k0f=:call EnterFileMode("dot")<CR>a
inoremap <buffer> <Leader>gm [msc, target=, align=center]<CR>--<CR>--<C-o>Omsc {<CR>}<C-o>O<Tab>hscale="1";<CR><,,><Esc>4k0f=:call EnterFileMode("mscgen")<CR>a
inoremap <buffer> <Leader>.s stem:[]<Left>
inoremap <buffer> <Leader>.S [stem]<CR>++++<CR>++++<C-o>O

inoremap <buffer> <Leader>sb ****<CR>****<C-o>O
inoremap <buffer> <Leader>eb ====<CR>====<C-o>O
inoremap <buffer> <Leader>qb ----<CR>----<C-o>O
inoremap <buffer> <Leader>ob --<CR>--<C-o>O
inoremap <buffer> <Leader>pb ++++<CR>++++<C-o>O
inoremap <buffer> <Leader>tt [.left, cols="", width=100, frame=sides, grid=cols, stripes=none]<CR>\|===<CR><,,><CR>\|===<Esc>3k0f"a
inoremap <buffer> <Leader>t, [.left, cols="", width=100, frame=sides, grid=cols, stripes=none]<CR>,===<CR><,,><CR>,===<Esc>3k0f"a
inoremap <buffer> <Leader>t: [.left, cols="", width=100, frame=sides, grid=cols, stripes=none]<CR>:===<CR><,,><CR>:===<Esc>3k0f"a
