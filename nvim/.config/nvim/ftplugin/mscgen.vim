nnoremap <Leader>m :write \| AsyncRun mscgen -Tpng -i % -o "${XDG_CACHE_HOME:-~/.cache}/vim-preview.png"<CR>
nnoremap <Leader>p :AsyncRun setsid sxiv -bps f "${XDG_CACHE_HOME:-~/.cache}/vim-preview.png"<CR>

inoremap <Leader>l label=""<Left>
inoremap <Leader>i \|\|\|;<CR>
inoremap <Leader>- --- [label=""];<C-o>F"
inoremap <Leader>b <C-o>"-yiw<End> box <C-r>- [label=""];<C-o>F"
inoremap <Leader>r <C-o>"-yiw<End> rbox <C-r>- [label=""];<C-o>F"
inoremap <Leader>a <C-o>"-yiw<End> abox <C-r>- [label=""];<C-o>F"
inoremap <Leader>n <C-o>"-yiw<End> note <C-r>- [label=""];<C-o>F"
