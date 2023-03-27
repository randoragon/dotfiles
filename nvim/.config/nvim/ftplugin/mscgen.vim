nnoremap <Leader>m :write \| AsyncRun mscgen -Tpng -i % -o "$VIM_PREVIEW_HOME/vim-preview.png"<CR>
nnoremap <Leader>p :AsyncRun setsid sxiv -bps f "$VIM_PREVIEW_HOME/vim-preview.png"<CR>

inoremap <Leader>l label=""<Left>
inoremap <Leader>i \|\|\|;<CR>
inoremap <Leader>- --- [label=""];<C-o>F"
inoremap <Leader>b <C-o>"-yiw<End> box <C-r>- [label=""];<C-o>F"
inoremap <Leader>r <C-o>"-yiw<End> rbox <C-r>- [label=""];<C-o>F"
inoremap <Leader>a <C-o>"-yiw<End> abox <C-r>- [label=""];<C-o>F"
inoremap <Leader>n <C-o>"-yiw<End> note <C-r>- [label=""];<C-o>F"
