nnoremap <buffer> <Leader>m :split \| terminal javac %<CR>

inoremap <buffer> <Leader>k package 
inoremap <buffer> <Leader>m import 
inoremap <buffer> <Leader>t static 
inoremap <buffer> <Leader>a abstract 
inoremap <buffer> <Leader>p public 
inoremap <buffer> <Leader>P private 
inoremap <buffer> <Leader>.p protected 
inoremap <buffer> <Leader>c class 
inoremap <buffer> <Leader>I implements 
inoremap <buffer> <Leader>E extends 

inoremap <buffer> <Leader>s String 
inoremap <buffer> <Leader>A ArrayList<> <,,><C-o>F<<C-o>F>
inoremap <buffer> <Leader>H HashMap<> <,,><C-o>F<<C-o>F>
inoremap <buffer> <Leader>/ /** 
inoremap <buffer> <Leader>2 {@link } <,,><C-o>F}

inoremap <buffer> <Leader>u unsigned 
inoremap <buffer> <Leader>S System.out.println()<Left>
inoremap <buffer> <Leader>.s switch () <,,><C-o>F)
inoremap <buffer> <Leader>r return 
inoremap <buffer> <Leader>i if () <,,><C-o>F)
inoremap <buffer> <Leader>e else 
inoremap <buffer> <Leader>o else if () <,,><C-o>F)
inoremap <buffer> <Leader>f for () <,,><C-o>F)
inoremap <buffer> <Leader>w while () <,,><C-o>F)
