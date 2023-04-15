"LINUX VIMRC

" Basic Settings {{{1
set nowrap
set number
set cursorline
set mouse=a
let mapleader=','
nnoremap <Leader>w :set wrap! linebreak!<CR>
map Y y$
set hidden
nnoremap c "_c
vnoremap <silent> . :normal .<CR>
nnoremap <silent> <Leader>/ :nohlsearch<CR>
nmap <PageUp> <C-u>
nmap <PageDown> <C-d>
filetype plugin indent on
set encoding=utf-8
set listchars=tab:\ \ ┊,trail:·,nbsp:·
set list
set timeoutlen=500
set history=1000
" }}}

" Plugins {{{1
lua << EOF
require 'paq' {
    'airblade/vim-gitgutter';
    'junegunn/fzf.vim';
    'tpope/vim-surround';
    'tpope/vim-speeddating';
    'tpope/vim-repeat';
    'tpope/vim-abolish';
    'tpope/vim-commentary';
    'glts/vim-radical';
    'glts/vim-magnum';
    'rebelot/kanagawa.nvim';
    'jiangmiao/auto-pairs';
    'godlygeek/tabular';
    'skywind3000/asyncrun.vim';
    'derekwyatt/vim-fswitch';
    'ap/vim-css-color';
    'psliwka/vim-smoothie';
    'lervag/vimtex';
    'ziglang/zig.vim';
    'Vigemus/iron.nvim';
    'famiu/bufdelete.nvim';
    'tiagovla/scope.nvim';
    'ggandor/lightspeed.nvim';
    {
        'nvim-treesitter/nvim-treesitter',
        run = function() vim.cmd('TSUpdate') end,
    };
}
EOF

" netrw (tree view) settings {{{2
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 30
let g:netrw_preview = 1
nmap <silent> <Leader>t :Lex!<CR>
" }}}

" AutoPairs {{{2
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutToggle = '<Leader>)'
let g:AutoPairsShortcutFastWrap = '<M-e>'
let g:AutoPairsShortcutJump = '<Nop>'
let g:AutoPairsShortcutBackInsert = '<Leader><Backspace>'
" }}}

" GitGutter {{{2
let g:gitgutter_map_keys = 0
nnoremap ]g :GitGutterNextHunk<CR>
nnoremap [g :GitGutterPrevHunk<CR>
nnoremap <Leader>gp :GitGutterPreviewHunk<CR>
nnoremap <Leader>gl :GitGutterLineHighlightsToggle<CR>
nnoremap <Leader>gu :GitGutterUndoHunk<CR>
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

" FZF {{{2
nnoremap <silent> <C-Space>  :GFiles<CR>
nnoremap <silent> <M-Space>  :Rg<CR>
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fl :Lines<CR>
nnoremap <silent> <Leader>fc :Commands<CR>
nnoremap <silent> <Leader>fm :Marks<CR>
nnoremap <silent> <Leader>fh :Helptags<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>
" }}}

" Smoothie {{{2
let g:smoothie_enabled = getenv("NVIM_SMOOTHIE_ENABLED")
if g:smoothie_enabled == v:null | let g:smoothie_enabled = 1 | endif
function! ToggleVimSmoothie()
    if g:smoothie_enabled
        let g:smoothie_enabled = 0
    else
        let g:smoothie_enabled = 1
    endif
endfunction
nnoremap <Leader>S :call ToggleVimSmoothie()<CR>
" }}}

" VimTex {{{2
" I use this plugin mostly for its motions and surround.vim-like support,
" so the majority of everything else can go.
let g:vimtex_compiler_enabled = 0
let g:vimtex_complete_enabled = 0
let g:vimtex_format_enables = 1
let g:vimtex_quickfix_enabled = 0
let g:vimtex_quickfix_blgparser = {'disable': 1}
let g:vimtex_syntax_conceal_disable = 1
let g:vimtex_view_enabled = 0
let g:vimtex_toc_config = {'layers': ['content', 'todo']}
let g:vimtex_indent_on_ampersands = 0

" surround.vim custom commands
augroup latex_surround_cmds
    autocmd!
    autocmd FileType tex let b:surround_105 = "\\emph{\r}"
    autocmd FileType tex let b:surround_98 = "\\textbf{\r}"
    autocmd FileType tex let b:surround_117 = "\\underline{\r}"
    autocmd FileType tex let b:surround_99 = "\\mintinline{\1syntax: \1}{\r}"
    autocmd FileType tex let b:surround_118 = "\\texttt{\r}"
    autocmd FileType tex let b:surround_120 = "\\text{\r}"
    autocmd FileType tex let b:surround_88 = "\\\1command: \1{\r}"
augroup END
" }}}

" Zig {{{2
" Disable automatic code formatting on write
let g:zig_fmt_autosave = 0
" }}}

" iron.nvim {{{2
lua require('plugins.iron')

nnoremap <silent> <Leader>i<Space> :IronRepl<CR><Esc>
nnoremap <silent> <Leader>ir :IronRestart<CR><Esc>
nnoremap <silent> <Leader>ie :IronFocus<CR>
nnoremap <silent> <M-(> :lua require('iron.core').run_motion('send_motion')<CR>ip<Esc>
nnoremap <silent> <M-)> :lua require('iron.core').run_motion('send_motion')<CR>ip<Esc>}+
nnoremap <silent> <M-9> :lua require('iron.core').send_line()<CR><Esc>
nnoremap <silent> <M-0> :lua require('iron.core').send_line()<CR><Esc>+
" }}}

" scope.nvim {{{2
lua require('scope').setup()
" }}}

" kanagawa.nvim {{{2
lua require('plugins.kanagawa')
" }}}

" nvim-treesitter {{{2
lua require('plugins.treesitter')
" }}}

" lightspeed.nvim {{{2
let g:lightspeed_last_motion = ''
augroup lightspeed_last_motion
autocmd!
autocmd User LightspeedSxEnter let g:lightspeed_last_motion = 'sx'
autocmd User LightspeedFtEnter let g:lightspeed_last_motion = 'ft'
augroup end
map <expr> ; g:lightspeed_last_motion == 'sx' ? "<Plug>Lightspeed_;_sx" : "<Plug>Lightspeed_;_ft"
map <expr> \ g:lightspeed_last_motion == 'sx' ? "<Plug>Lightspeed_,_sx" : "<Plug>Lightspeed_,_ft"
" }}}

" }}}

"{{{1 QuickFix/Location List
" https://vi.stackexchange.com/a/8535
command! Cnext try | cnext | catch /^Vim\%((\a\+)\)\=:E553:/ | cfirst | catch | echo "No quickfix list" | endtry
command! Cprev try | cprev | catch /^Vim\%((\a\+)\)\=:E553:/ | clast  | catch | echo "No quickfix list" | endtry
command! Lnext try | lnext | catch /^Vim\%((\a\+)\)\=:E553:/ | lfirst | catch | echo "No location list" | endtry
command! Lprev try | lprev | catch /^Vim\%((\a\+)\)\=:E553:/ | llast  | catch | echo "No location list" | endtry
nnoremap <silent> [q :Cprev<CR>
nnoremap <silent> ]q :Cnext<CR>
nnoremap <silent> [d :Lprev<CR>
nnoremap <silent> ]d :Lnext<CR>

" https://rafaelleru.github.io/blog/quickfix-autocomands/
let g:clist_isopen = 0
let g:llist_isopen = 0
function! ToggleCList()
    if g:clist_isopen
        cclose
        let g:clist_isopen = 0
    else
        copen
        let g:clist_isopen = 1
    endif
endfunction
function! ToggleLList()
    if g:llist_isopen
        lclose
        let g:llist_isopen = 0
    else
        lopen
        let g:llist_isopen = 1
    endif
endfunction
function! QFListSetState()
    if getwininfo(win_getid())[0]['loclist']
        let g:llist_isopen = 1
    else
        let g:lcist_isopen = 1
    endif
endfunction
function! QFListUnsetState()
    if getwininfo(win_getid())[0]['loclist']
        let g:llist_isopen = 0
    else
        let g:lcist_isopen = 0
    endif
endfunction
augroup qffixstates
    autocmd!
    autocmd BufWinEnter quickfix call QFListSetState()
    autocmd BufWinLeave quickfix call QFListUnsetState()
augroup END
nnoremap <silent> <Leader>q :call ToggleCList()<CR>
nnoremap <silent> <Leader>d :try \| call ToggleLList() \| catch \| echo "No location list" \| endtry<CR>
"}}}

"{{{1 LSP Configuration
let g:project_mode = 0
nnoremap <silent> <Leader>p :let g:project_mode = !g:project_mode<CR>
nnoremap <Space> <Nop>

function! ConfigureLSP()
    set omnifunc=v:lua.vim.lsp.omnifunc
    lua vim.diagnostic.config({virtual_text=false})
    nnoremap <silent> <Leader><C-l> :call v:lua.vim.diagnostic.reset()<CR>
    nnoremap <silent> <Leader>e :call v:lua.vim.diagnostic.open_float()<CR>
    nnoremap <silent> <Leader>[e :call v:lua.vim.diagnostic.goto_prev()<CR>
    nnoremap <silent> <Leader>]e :call v:lua.vim.diagnostic.goto_next()<CR>
    nnoremap <silent> <Leader>D :call v:lua.vim.diagnostic.setloclist()<CR>
    nnoremap <silent> gd :call v:lua.vim.lsp.buf.definition()<CR>
    nnoremap <silent> gD :call v:lua.vim.lsp.buf.declaration()<CR>
    nnoremap <silent> <Space> :call v:lua.vim.lsp.buf.hover()<CR>
    nnoremap <silent> <Leader><Space> :call v:lua.vim.lsp.buf.signature_help()<CR>
    nnoremap <silent> <Leader>r :call v:lua.vim.lsp.buf.references()<CR>
    nnoremap <silent> <Leader>R :call v:lua.vim.lsp.buf.rename()<CR>
endfunction
augroup lsp
    autocmd!
    autocmd BufEnter * if g:project_mode && exists('g:active_lsp_config') | let b:active_lsp_client = v:lua.vim.lsp.start(g:active_lsp_config) | endif
    autocmd LspAttach * call ConfigureLSP()
    autocmd DiagnosticChanged * lua vim.diagnostic.setloclist({open=false})
    autocmd ColorScheme *
                \  highlight MyProjectMode ctermfg=7 ctermbg=6 cterm=bold guifg=White guibg=DarkCyan gui=bold
                \| highlight MyStatusBarWarn ctermfg=3 ctermbg=3 cterm=bold guifg=Orange guibg=#4b2800 gui=bold
                \| highlight MyStatusBarError ctermfg=1 ctermbg=1 cterm=bold guifg=Red guibg=#4b0000 gui=bold
augroup END
"}}}

" Status Bar{{{1
" https://jdhao.github.io/2019/11/03/vim_custom_statusline/
" https://shapeshed.com/vim-statuslines/
set statusline=
set statusline+=%#MyProjectMode#%{g:project_mode?'·':''}       " Project Mode indicator
set statusline+=%{%luaeval(\"require('lsp').status()\")%}      " LSP warnings/errors
set statusline+=%#Visual#\ %f\                                 " File path
set statusline+=%#WarningMsg#%h%m%r                            " {help, modified, readonly} flags
set statusline+=%#CursorColumn#%=                              " Align the rest to the right
set statusline+=%#Conceal#%y\                                  " File type
set statusline+=%{&fileencoding?&fileencoding:&encoding}\      " File encoding
set statusline+=%#MsgArea#\ \ %v:%l/%L\ (%p%%)\                " Position in file
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
function! ToggleIndentStyle()
    if &expandtab
        " 8-character wide tabs
        set noexpandtab
        set shiftwidth=8
        set tabstop=8
        set softtabstop=0
    else
        " 4-character wide spaces
        set expandtab
        set shiftwidth=4
        set tabstop=4
        set softtabstop=4
    endif
endfunction
nnoremap <Leader>T :call ToggleIndentStyle()<CR>

set expandtab
call ToggleIndentStyle()

" For markdown folding, src: https://stackoverflow.com/a/4677454 (comments) {{{2
function MarkdownLevel()
    let h = matchstr(getline(v:lnum), '^#\+')
    if empty(h)
        return "="
    else
        return ">" . len(h)
    endif
endfunction

nnoremap <M-i> zA
nnoremap <M-I> za
nnoremap <M-m> zM
nnoremap <M-r> zR
" }}}

augroup fold_switch
    autocmd!
    autocmd! BufNewFile,BufRead * :normal zR
    autocmd! BufNewFile,BufRead .vimrc,init.vim     setlocal foldmethod=marker foldlevel=0
    autocmd! BufNewFile,BufRead *.c,*.h,*.cpp,*.hpp setlocal foldmethod=indent | :normal zR
    autocmd! BufNewFile,BufRead *.py      setlocal foldmethod=indent | :normal zR
    autocmd! BufNewFile,BufRead *.md,*.MD setlocal foldmethod=expr foldexpr=MarkdownLevel() foldnestmax=3 foldlevel=1
augroup END

" }}}

" New file templates {{{1
function TryLoadTemplate()
    let fpath = $HOME."/.config/nvim/templates/".&filetype
    echo l:fpath
    if filereadable(fpath)
        call setline(1, readfile(l:fpath))

        let datestr = strftime('%A, %B %e, %Y')
        let l = 1
        for line in getline(1, '$')
            " Substitute <DATE> with the current date
            call setline(l:l, substitute(l:line, '\C<DATE>', l:datestr, 'g'))
            let l = l:l + 1
        endfor

        " Place cursor in the spot indicated by <START>
        call searchpos('\C<START>')
        norm "_df>
    endif
endfunction
augroup new_file_templates
    autocmd!
    autocmd! BufNewFile * call TryLoadTemplate()
augroup END
" }}}

" FSwitch settings {{{1
augroup file_switch
    autocmd! BufEnter *.cpp let b:fswitchdst = 'hpp,h' | let b:fswitchlocs = '.'
    autocmd! BufEnter *.c   let b:fswitchdst = 'h'     | let b:fswitchlocs = '.'
augroup END
nnoremap <silent> <C-s> :FSHere<CR>
" }}}

" Searching {{{1
set ignorecase
set smartcase
" }}}

" Binary file editing {{{1
" requires xxd, on Arch install xxd-standalone from AUR

" Convert to and from hexdump
nnoremap <silent> <Leader>x :%!xxd<CR>:set filetype=xxd<CR>
nnoremap <silent> <Leader>X :%!xxd -r<CR>:filetype detect<CR>
" }}}

" Window Shortcuts {{{1
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
nnoremap <Bar> <C-w><Bar>
nnoremap _ <C-w>_
nnoremap <silent> <M-s> :vsplit<CR>
nnoremap <silent> <Leader><M-s> :split<CR>
set splitbelow
set splitright

nnoremap <silent> <M-CR> :w<CR>
nnoremap <silent> <M-q> :q<CR>
nnoremap <silent> <M-w> :Bdelete<CR>
nnoremap <silent> <Leader><M-CR> :w!<CR>
nnoremap <silent> <Leader><M-q> :q!<CR>
nnoremap <silent> <Leader><M-w> :Bdelete!<CR>

nnoremap <silent> <M-n> :bnext<CR>
nnoremap <silent> <M-p> :bNext<CR>

nnoremap <silent> <M-t> :tabnew<CR>
nnoremap <silent> <M-[> :tabprevious<CR>
nnoremap <silent> <M-]> :tabnext<CR>
nnoremap <silent> <M-{> :-tabmove<CR>
nnoremap <silent> <M-}> :+tabmove<CR>
" }}}

" Map common motions to alt (Meta) modifier {{{1
" I use these motions all the time and pressing control causes strain on my
" pinkie finger. Alt can be pressed with the thumb which is easier.
inoremap <M-h> <Left>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-l> <Right>

nmap <M-d> <C-d>
nmap <M-u> <C-u>
nmap <M-f> <C-f>
nmap <M-b> <C-b>
" }}}

" Copy shortcuts {{{1
nnoremap <silent> <M-a> :%y+<CR>
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
inoremap <Leader><C-d> <C-r>=strftime('%Y-%m-%d')<CR>
inoremap <Leader>.<C-d> <C-r>=strftime('%A, %B %e, %Y')<CR>
" }}}

" Backup directories {{{1
set backup
set writebackup
set backupdir=~/.local/share/nvim/backup/
" }}}

" Make motions more wrap-friendly {{{1
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
" }}}

" Enable 256 color support, set colorscheme {{{1
syntax enable
if $DISPLAY != ""
    set termguicolors
    set background=dark
    colorscheme kanagawa
    if &term =~ '256color'
        " Disable background color erase (BCE) so that color schemes
        " work properly when Vim is used inside tmux and GNU screen
        set t_ut=
    endif
else
    " fallback colorscheme for TTY
    colorscheme ron
endif

" Make background transparent on any colorscheme, embolden current line number
function TransparentBG()
    highlight Normal       guibg=NONE ctermbg=NONE
    highlight Title        guibg=NONE ctermbg=NONE
    highlight LineNr       guibg=NONE ctermbg=NONE
    highlight Folded       guibg=NONE ctermbg=NONE
    highlight NonText      guibg=NONE ctermbg=NONE
    highlight FoldColumn   guibg=NONE ctermbg=NONE
    highlight SignColumn   guibg=NONE ctermbg=NONE
    highlight CursorLine   guibg=NONE ctermbg=NONE
    highlight CursorLineNr guibg=NONE ctermbg=NONE
endfunction
autocmd VimEnter,ColorScheme * call TransparentBG()
" }}}

" Searching configuration {{{1
set wildmenu
set wildmode=longest:full,full
set wildignorecase
set wildignore=*.git/*,*.tags,*.o
cnoremap <expr> / wildmenumode() ? "\<C-E>" : "/"
set path+=** " Enables recursive :find
" }}}

"{{{1 Center screen after search
nnoremap n nzz
nnoremap N Nzz
"1}}}

"{{{1 Automatically enter insert mode when starting a terminal in NeoVim
"https://github.com/neovim/neovim/issues/8816#issuecomment-410512452
if has('nvim')
    autocmd TermOpen term://* startinsert
endif
"}}}

"{{{1 Provide EnterFileMode function for scripts
function! EnterFileMode(filetype)
    let &filetype = a:filetype
    nnoremap <buffer> <Leader><Leader> :set filetype=asciidoc<CR>
                \:nunmap <buffer> <Leader><Leader><CR>
                \:echo<CR>
    echo "Entered ".a:filetype." mode. Press <Leader> twice to exit."
endfunction
"}}}

"{{{1 ShaDa configuration
set shada="!,'0,/100,<100,s10,h"

" Read and write ShaDa automatically to share state between instances
augroup shada
    autocmd!
    autocmd VimEnter,FocusGained,CursorHold * silent! rshada
    autocmd FocusLost,TextYankPost,RecordingLeave * silent! wshada
augroup END
"}}}

"{{{1 <,,> marker configuration
function! NextInsMarker()
    if search("<,,>", "cswz") == 0
        throw "No markers present."
    endif
endfunction

function GetLastSelection()
    let [line1, ncol1] = getpos("'<")[1:2]
    let [line2, ncol2] = getpos("'>")[1:2]
    let lines = getline(line1, line2)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][:ncol2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][ncol1 - 1:]
    while lines[0][0] == "\t"
        let lines[0] = lines[0][1:]
    endwhile
    return join(lines, "\n")
endfunction

" Jump to next marker and enter insert mode
nnoremap <silent> <M-o> :call NextInsMarker()<CR>"_cf>
inoremap <silent> <M-o> <Esc>:call NextInsMarker()<CR>"_cf>

" Get current line/selection and paste at the next marker
nnoremap <silent> <M-O> ^"py$:call NextInsMarker()<CR>"pPl"_df>
inoremap <silent> <M-O> <Esc>^"py$:call NextInsMarker()<CR>"pPl"_df>
vnoremap <silent> <M-O> <Esc>:call NextInsMarker()<CR>"=GetLastSelection()<CR>Pl"_df>
"}}}
