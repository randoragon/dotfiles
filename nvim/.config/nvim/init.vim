"LINUX VIMRC

" Basic Settings {{{1
set nowrap
set number
set path+=** " Enables recursive :find
set mouse=a
let mapleader=','
nnoremap \ ,
nnoremap <Leader>w :set wrap! linebreak!<CR>
map Y y$
set hidden
" }}}

" Plugins {{{1
call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'glts/vim-radical'
Plug 'glts/vim-magnum'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'flazz/vim-colorschemes'
Plug 'ternjs/tern_for_vim'
Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'
Plug 'skywind3000/asyncrun.vim'
Plug 'derekwyatt/vim-fswitch'
call plug#end()

" Airline {{{2
let g:airline_detect_spell=0
let g:airline_detect_spellang=0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#ale#enabled=1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#ycm#enabled = 1
" }}} 

" AutoPairs {{{2
let g:AutoPairsFlyMode = 1
let g:AutoPairsMapCR = 1
" }}}

" Tabular keyboard shortcuts {{{2
vnoremap <M-=> :Tabular/=<CR>
vnoremap <M-,> :Tabular/,/l0r1<CR>
vnoremap <M-;> :Tabular/;/l0r1<CR>
" }}}

" ALE {{{2
nnoremap <Leader>e :ALEDetail<CR>
nnoremap <Leader>a :ALEToggle<CR>
nnoremap <Leader>n :ALENextWrap<CR>
nnoremap <Leader>N :ALEPreviousWrap<CR>
" }}} 

" Auto Pairs {{{2
let g:AutoPairsShortcutToggle='<Leader>0'
" }}}

" FZF {{{2
nnoremap <C-f> <Nop>
nnoremap <C-b> <Nop>
nnoremap <C-f>f     : Files<CR>
nnoremap <C-f><C-f> : Files<CR>
nnoremap <C-f>l     : Lines<CR>
nnoremap <C-f><C-l> : Lines<CR>
nnoremap <C-f>c     : Commands<CR>
nnoremap <C-f><C-c> : Commands<CR>
nnoremap <C-f>t     : Tags<CR>
nnoremap <C-f><C-t> : Tags<CR>
nnoremap <C-f>m     : Marks<CR>
nnoremap <C-f><C-m> : Marks<CR>
nnoremap <C-f>h     : Helptags<CR>
nnoremap <C-f><C-h> : Helptags<CR>
nnoremap <C-f>a     : Ag<CR>
nnoremap <C-f><C-a> : Ag<CR>
nnoremap <C-f>b     : Buffers<CR>
nnoremap <C-f><C-b> : Buffers<CR>
" }}}

" }}}

" Clipboard Integration {{{1
let g:clipboard = {
 \    'name': 'xclip',
 \    'copy': {
 \        '+': 'xclip -selection clipboard',
 \        '*': 'xclip -selection clipboard'
 \    },
 \    'paste': {
 \        '+': 'xclip -o',
 \        '*': 'xclip -o'
 \    },
 \    'cache_enabled': 1,
 \ }
" }}}

" Indentation settings {{{1
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
" }}}

" Fold settings {{{1
set foldmethod=manual

" For markdown folding, src: https://stackoverflow.com/a/4677454 (comments) {{{2
function MarkdownLevel()
    let h = matchstr(getline(v:lnum), '^#\+')
    if empty(h)
        return "="
    else
        return ">" .  len(h)
    endif
endfunction
" }}}

augroup fold_switch
    autocmd!
    autocmd BufWinEnter * :normal zR
    autocmd! BufWinEnter .vimrc,init.vim    setlocal foldmethod=marker foldlevel=0
    autocmd! BufWinEnter *.c,*.h,*.cpp,*.hpp setlocal foldmethod=syntax | :normal zR
    autocmd! BufWinEnter *.py      setlocal foldmethod=indent | :normal zR
    autocmd! BufWinEnter *.md      setlocal foldmethod=expr foldexpr=MarkdownLevel() foldnestmax=3 foldlevel=1
augroup END
" }}}

" FSwitch settings {{{1
augroup file_switch
    autocmd! BufEnter *.cpp let b:fswitchdst = 'hpp,h' | let b:fswitchlocs = '.'
    autocmd! BufEnter *.c   let b:fswitchdst = 'h'     | let b:fswitchlocs = '.'
augroup END
nnoremap <C-s> :FSHere<CR>
" }}}

" Searching {{{1
set ignorecase
set smartcase
" }}}

" Binary file editing {{{1
" requires xxd, on Arch install xxd-standalone from AUR

" Open *.bin files in binary mode
augroup Binary
    au!
    au BufReadPre  *.bin let &bin=1
    au BufReadPost *.bin if &bin | %!xxd
    au BufReadPost *.bin set ft=xxd | endif
    au BufWritePre *.bin if &bin | %!xxd -r
    au BufWritePre *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END

" Convert to and from hexdump
nnoremap <Leader>d :%!xxd<CR>:set filetype=xxd<CR>
nnoremap <Leader>D :%!xxd -r<CR>:filetype detect<CR>
" }}}

" Window Shortcuts {{{1
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Bar> <C-w><Bar>
nnoremap _ <C-w>_
nnoremap <C-w>x :Bclose<CR>
set splitbelow
set splitright

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bNext<CR>

nnoremap <S-h> :tabprevious<CR>
nnoremap <S-l> :tabnext<CR>
nnoremap g<S-h> :-tabmove<CR>
nnoremap g<S-l> :+tabmove<CR>

nnoremap gt <S-h>
nnoremap gT <S-l>
" }}}

" Backup directories {{{1
set backup
set writebackup
set backupdir=~/.local/share/nvim/backup/
" }}}

" Force redraw shortcut {{{1
nnoremap <Leader>l :redraw!<CR>
" }}}

" Make motions more wrap-friendly {{{1
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
" }}}

" Fullscreen shortcut {{{1
map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>
" }}}

" Markdown Preview config {{{1
function PreviewMarkdown()
    write
	AsyncRun mdtopdf "%:p" "/tmp/vim_preview.pdf"
endfunction
nnoremap <Leader>pm :call PreviewMarkdown()<CR>
nnoremap <Leader>po :AsyncRun setsid xdg-open /tmp/vim_preview.pdf<CR>
" }}}

" netrw (tree view) settings {{{1
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 30
let g:netrw_preview = 1
nmap <silent> <Leader>t :Lex!<CR>

" Suppress some netrw maps
" (Source: https://stackoverflow.com/questions/34136749/remove-netrw-s-up-and-s-down-mapping-in-vim)
augroup netrw_maps
  autocmd!
  autocmd filetype netrw call ApplyNetrwMaps()
augroup END

function ApplyNetrwMaps()
    nnoremap <buffer> <C-h> <C-w>h
    nnoremap <buffer> <C-j> <C-w>j
    nnoremap <buffer> <C-k> <C-w>k
    nnoremap <buffer> <C-l> <C-w>l
endfunction
" }}}

" Enable 256 color support, set colorscheme {{{1
set termguicolors
colorscheme gruvbox
set background=dark
if &term =~ '256color'
    " Disable background color erase (BCE) so that color schemes
    " work properly when Vim is used inside tmux and GNU screen
    set t_ut=
endif
" }}}

