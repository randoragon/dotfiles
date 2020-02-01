"LINUX VIMRC

" Plugins {{{1
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'ycm-core/YouCompleteMe'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'
Plug 'tpope/vim-repeat'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'flazz/vim-colorschemes'
Plug 'ternjs/tern_for_vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'nessss/vim-gml'
Plug 'godlygeek/tabular'
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
vnoremap = :Tabular/=<CR>
vnoremap , :Tabular/,/l0r1<CR>
vnoremap ; :Tabular/;/l0r1<CR>
" }}}

" ALE {{{2
nnoremap <Leader>e :ALEDetail<CR>
nnoremap <Leader>a :ALEToggle<CR>
" }}} 

" Auto Pairs {{{2
let g:AutoPairsShortcutToggle='<Leader>0'
" }}}

" FZF {{{2
nnoremap <C-F>f :Files<CR>
nnoremap <C-F>l :Lines<CR>
nnoremap <C-F>c :Commands<CR>
nnoremap <C-F>t :Tags<CR>
nnoremap <C-F>m :Marks<CR>
nnoremap <C-F>h :Helptags<CR>
nnoremap <C-F>a :Ag<CR>
" }}}

" }}}

" Basic Settings {{{1
filetype plugin indent on
syntax on
set encoding=utf-8
set nocompatible
set nowrap
set number
set path+=** " Enables recursive :find
set showcmd
let mapleader=','
nnoremap \ ,
map Y y$
set backspace=indent,eol,start
set hidden
set wildmenu
set ruler
" }}}

" Indentation settings {{{1
set autoindent
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
" }}}

" Fold settings {{{1
set foldmethod=syntax

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
    autocmd BufRead,BufNewFile .vimrc setlocal foldmethod=marker | set foldlevel=0
    autocmd BufRead,BufNewFile *.py setlocal foldmethod=indent foldnestmax=2
    autocmd BufRead,BufNewFile *.md setlocal foldmethod=expr foldexpr=MarkdownLevel() foldnestmax=3 foldlevel=1
augroup END
" }}}

" Searching {{{1
set incsearch
set ignorecase
set smartcase
" }}}

" Window Shortcuts {{{1
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
set splitbelow
set splitright
nnoremap <C-w>l :set splitright<CR>:vnew<CR>
nnoremap <C-w>h :set nosplitright<CR>:vnew<CR>:set splitright<CR>
nnoremap <C-w>j :set splitbelow<CR>:new<CR>
nnoremap <C-w>k :set nosplitbelow<CR>:new<CR>:set splitbelow<CR>
nnoremap L gt
nnoremap H gT
" }}}

" Backup directories {{{1
set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/backup//
set writebackup
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
	:silent !touch /tmp/vim_markdown.html "/tmp/vim_markdown.pdf
	:silent !pandoc -c ~/Documents/markdown_stylesheet.css -o /tmp/vim_markdown.html  %:p
    ":silent !wkhtmltopdf /tmp/vim_markdown.html /tmp/vim_markdown.pdf
    ":silent !evince -w /tmp/vim_markdown.pdf &
    ":silent !epiphany /tmp/vim_markdown.html 2> /dev/null &
    :redraw!
endfunction
nnoremap <Leader>p :call PreviewMarkdown()<CR>
" }}}

" netrw (tree view) settings {{{1
let g:netrw_banner = 0
let g:netrw_liststyle = 0
let g:netrw_winsize = 25
nmap <silent> <Leader>t :Vex!<CR>
" }}}

" Disable toolbars in gVim {{{1
if has("gui_running")
	set guioptions-=T
	set guioptions-=m
endif
" }}}

" Enable 256 color support, set colorscheme {{{1
set t_Co=256
colorscheme gruvbox
set background=dark
if &term =~ '256color'
    " Disable background color erase (BCE) so that color schemes
    " work properly when Vim is used inside tmux and GNU screen
    set t_ut=
endif
" }}}

