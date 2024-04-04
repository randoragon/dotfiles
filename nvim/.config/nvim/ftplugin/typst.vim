setl tabstop=4 shiftwidth=4

" Preview
nnoremap <buffer> <Leader>m :write \| AsyncRun typst compile -- "%:p" "$VIM_PREVIEW_HOME/vim-preview.pdf" 2>"$VIM_PREVIEW_HOME/vim-preview.log"<CR>
nnoremap <buffer> <Leader>.m :view $VIM_PREVIEW_HOME/vim-preview.log"<CR>:syn match Error '[Ee]rror:'<CR>:syn match DbgBreakPt '[Ww]arning:'<CR>GM
nnoremap <buffer> <Leader>p :AsyncRun setsid xdg-open "$VIM_PREVIEW_HOME/vim-preview.pdf"<CR>

" Misc
inoremap <buffer> <Leader>= #let  = [<,,>]<C-o>8h
inoremap <buffer> <Leader>C #columns()[<,,>]<C-o>F)
inoremap <buffer> <Leader>.C #colbreak()
inoremap <buffer> <Leader>f #footnote[] <,,><C-o>F]
inoremap <buffer> <Leader>f #footnote[] <,,><C-o>F]

" Text formatting
inoremap <buffer> <Leader>h #highlight[]<Left>
inoremap <buffer> <Leader>l #link("") <,,><C-o>F"
inoremap <buffer> <Leader>s #strike[]<Left>
inoremap <buffer> <Leader>_ #sub[]<Left>
inoremap <buffer> <Leader>^ #super[]<Left>
inoremap <buffer> <Leader>u #underline[]<Left>
inoremap <buffer> <Leader>c ``````<Left><Left><Left>
inoremap <buffer> <Leader>e $$ <,,><C-o>F$
inoremap <buffer> <Leader>E $  $<Left><Left>

" Figures
inoremap <buffer> <Leader>F #figure(<CR><Tab>image("", width: 80%),<CR>caption: [<,,>],<CR>) <<,,>><Esc>2k$F"i

" Tables
inoremap <buffer> <Leader>tt #table(<CR><Tab>columns: (),<CR>align: (<,,>),<CR>table.header[<,,>],<CR>)<Esc><<3kf)i
inoremap <buffer> <Leader>th table.hline()
inoremap <buffer> <Leader>tv table.vline()
inoremap <buffer> <Leader>tc table.cell(colspan: , [<,,>])<C-o>8h
inoremap <buffer> <Leader>tr table.cell(rowspan: , [<,,>])<C-o>8h
