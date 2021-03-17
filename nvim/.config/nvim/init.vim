"LINUX VIMRC

" Basic Settings {{{1
set nowrap
set number
set mouse=a
let mapleader=','
nnoremap \ ,
nnoremap <Leader>w :set wrap! linebreak!<CR>
map Y y$
set hidden
nnoremap c "_c
vnoremap . :normal .<CR>
filetype plugin indent on
" }}}

" Plugins {{{1
call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'glts/vim-radical'
Plug 'glts/vim-magnum'
Plug 'dense-analysis/ale'
Plug 'nanotech/jellybeans.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'
Plug 'skywind3000/asyncrun.vim'
Plug 'derekwyatt/vim-fswitch'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-clangx'
Plug 'psliwka/vim-smoothie'
Plug 'ap/vim-css-color'
Plug 'junegunn/goyo.vim'
Plug 'thinca/vim-quickrun'
call plug#end()

" netrw (tree view) settings {{{2
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 30
let g:netrw_preview = 1
nmap <silent> <Leader>t :Lex!<CR>
" }}}

" AutoPairs {{{2
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutToggle = '<Leader>0'
let g:AutoPairsShortcutBackInsert = '<Leader><Backspace>'
" }}}

" GitGutter {{{2
nnoremap ]h :GitGutterNextHunk<CR>
nnoremap [h :GitGutterPrevHunk<CR>
nnoremap <Leader>h :GitGutterPreviewHunk<CR>
" }}}

" Tabular keyboard shortcuts {{{2
vnoremap <Leader>t= :Tabular/=<CR>
vnoremap <Leader>t- :Tabular/-<CR>
vnoremap <Leader>t+ :Tabular/+<CR>
vnoremap <Leader>t< :Tabular/<<CR>
vnoremap <Leader>t> :Tabular/><CR>
vnoremap <Leader>t, :Tabular/,/l0r1<CR>
vnoremap <Leader>t; :Tabular/;/l0r1<CR>
" }}}

" ALE & Deoplete {{{2
let g:ale_enabled = 0
let g:deoplete#enable_at_startup = 0
" Close Deoplete preview window after completion
" https://github.com/Shougo/deoplete.nvim/issues/115
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif
nnoremap <Leader>a :ALEToggle<CR>:call deoplete#toggle()<CR>
nnoremap <Leader>e :ALEDetail<CR>
nnoremap ]a :ALENextWrap<CR>
nnoremap [a :ALEPreviousWrap<CR>
" }}} 

" FZF {{{2
nnoremap <C-Space>  :GFiles<CR>
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fl :Lines<CR>
nnoremap <Leader>fc :Commands<CR>
nnoremap <Leader>ft :Tags<CR>
nnoremap <Leader>fm :Marks<CR>
nnoremap <Leader>fh :Helptags<CR>
nnoremap <Leader>fa :Ag<CR>
nnoremap <Leader>fb :Buffers<CR>
" }}}

" {{{2 Deoplete
" }}}

" {{{2 Goyo
nnoremap <Leader>g :Goyo<CR>
" }}}

" {{{2 QuickRun
let g:quickrun_no_default_key_mappings = 1
nnoremap <Leader>qr :QuickRun<CR>
" }}}

" }}}

" Status Bar{{{1
" https://jdhao.github.io/2019/11/03/vim_custom_statusline/
" https://shapeshed.com/vim-statuslines/

set statusline=
set statusline+=%#PmenuSel#\ %n\                           " Buffer number
set statusline+=%#Visual#\ %F\                             " File path
set statusline+=%#WarningMsg#%h%m%r                        " {help, modified, readonly} flags
set statusline+=%#CursorColumn#%=                          " Align the rest to the right
set statusline+=%#Conceal#%y\                              " File type
set statusline+=%{&fileencoding?&fileencoding:&encoding}\  " File encoding
set statusline+=%#MsgArea#\ \ %c:%l/%L\ (%p%%)\            " Position in file
set statusline+=\ 

" }}}

" Clipboard Integration {{{1
let g:clipboard = {
 \    'name': 'xclip',
 \    'copy': {
 \        '+': 'xclip -selection clipboard',
 \        '*': 'xclip -selection clipboard'
 \    },
 \    'paste': {
 \        '+': 'xclip -selection clipboard -o',
 \        '*': 'xclip -o'
 \    },
 \    'cache_enabled': 1,
 \ }
" }}}

" Spell-check settings {{{1
set spelllang=en_us
nnoremap <Leader>s :set spell!<CR>
" }}}

" Indentation settings {{{1
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
" }}}

" File type detection settings {{{1
augroup filetype_detect
    autocmd! BufEnter *.MD  :set filetype=markdown
    autocmd! BufEnter *.mom :set filetype=groff
    autocmd! BufEnter *.ms  :set filetype=groff
augroup END
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
    autocmd! BufWinEnter .vimrc,init.vim     setlocal foldmethod=marker foldlevel=0
    autocmd! BufWinEnter *.c,*.h,*.cpp,*.hpp setlocal foldmethod=syntax | :normal zR
    autocmd! BufWinEnter *.py      setlocal foldmethod=indent | :normal zR
    autocmd! BufWinEnter *.md,*.MD setlocal foldmethod=expr foldexpr=MarkdownLevel() foldnestmax=3 foldlevel=1
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

" Copy shortcuts {{{1
nnoremap <M-a> :%y+<CR>
vnoremap <M-a> "+y
inoremap <M-a> <ESC>:%y+<CR>a
" }}}

" Insert Mode Shortcuts {{{1

" Shell or Emacs-like shortcuts
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-y> <C-o>P

" Paste current date
inoremap <C-d> <C-r>=strftime('%a %Y-%m-%d')<CR>
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

" Documents preview config {{{1
function Preview()
    write
    if &filetype == "markdown"
        AsyncRun mdtopdf "%:p" "${XDG_CACHE_HOME:-~/.cache}/vim_preview.pdf"
    elseif &filetype == "groff"
        AsyncRun pdfmom -t -e "%:p" > "${XDG_CACHE_HOME:-~/.cache}/vim_preview.pdf"
    endif
endfunction
nnoremap <Leader>pm :call Preview()<CR>
nnoremap <Leader>po :AsyncRun setsid xdg-open "${XDG_CACHE_HOME:-~/.cache}/vim_preview.pdf"<CR>
" }}}

" Enable 256 color support, set colorscheme {{{1
syntax enable
let g:palenight_terminal_italics = 1
let g:jellybeans_use_term_italics = 1
let g:badwolf_darkgutter = 1
if $DISPLAY != ""
    set termguicolors
    set background=dark
    colorscheme jellybeans
    if &term =~ '256color'
        " Disable background color erase (BCE) so that color schemes
        " work properly when Vim is used inside tmux and GNU screen
        set t_ut=
    endif
else
    " fallback colorscheme for TTY
    colorscheme ron
endif
" }}}

" Searching configuration {{{1
set wildmenu
set wildmode=longest:full,full
set wildignorecase
set wildignore=*.git/*,*.tags,*.o
cnoremap <expr> / wildmenumode() ? "\<C-E>" : "/"
set path+=** " Enables recursive :find
" }}}
