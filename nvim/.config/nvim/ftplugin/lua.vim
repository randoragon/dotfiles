inoremap <buffer> <M-p> <Esc>/<,,><CR>"_cf>

nnoremap <buffer> <Leader>m :write \| split \| terminal lua -i %<CR>
inoremap <buffer> <M-n> <C-o>o
set tw=80
inoremap <buffer> <Leader>l local 
inoremap <buffer> <Leader>r return 
inoremap <buffer> <Leader>i if 
inoremap <buffer> <Leader>T then<CR>end<Esc>O
inoremap <buffer> <Leader>e else
inoremap <buffer> <Leader>o elseif 
inoremap <buffer> <Leader>f for 
inoremap <buffer> <Leader>w while 
inoremap <buffer> <Leader>F function 
inoremap <buffer> <Leader>c <const> 

inoremap <buffer> <Leader>p print()<Left>
inoremap <buffer> <Leader>I ipairs()<Left>
inoremap <buffer> <Leader>P pairs()<Left>
inoremap <buffer> <Leader>d do<CR>end<Esc>O
inoremap <buffer> <Leader>ss string.
inoremap <buffer> <Leader>sf string.format()<Left>

inoremap <buffer> <Leader>tt table.
inoremap <buffer> <Leader>ti table.insert()<Left>
inoremap <buffer> <Leader>tr table.remove()<Left>
inoremap <buffer> <Leader>tc table.concat()<Left>
inoremap <buffer> <Leader>tm table.move()<Left>
inoremap <buffer> <Leader>t[ <Esc>^y$A[#<C-r>" + 1] = 

inoremap <buffer> += <Esc>y^gi= <C-r>" +
inoremap <buffer> -= <Esc>y^gi= <C-r>" -
inoremap <buffer> *= <Esc>y^gi= <C-r>" *
inoremap <buffer> /= <Esc>y^gi= <C-r>" /
inoremap <buffer> //= <Esc>y^gi= <C-r>" //
inoremap <buffer> %= <Esc>y^gi= <C-r>" %
inoremap <buffer> ^= <Esc>y^gi= <C-r>"^
inoremap <buffer> &= <Esc>y^gi= <C-r>" &
inoremap <buffer> \|= <Esc>y^gi= <C-r>" \|
inoremap <buffer> >>= <Esc>y^gi= <C-r>" >>
inoremap <buffer> <<= <Esc>y^gi= <C-r>" <<

command LSPFileToggleLua    lua require('lsptools').toggle('lualsp', {'lua-language-server'})
command LSPProjectToggleLua lua require('lsptools').toggle('lualsp', {'lua-language-server'},
            \ {
            \  '.git',
            \  'init.lua',
            \  'Makefile', 'makefile', 'GNUmakefile',
            \  'CMakeLists.txt'
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleLua<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleLua<CR>
