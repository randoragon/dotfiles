setl tabstop=4 shiftwidth=4
nnoremap <Leader>.t :VimtexTocOpen<CR>

" Helper binds for inserting \\ at the end of a line
function AppendDoubleBackslash()
    let line = getline('.')
    while line[-1] == ' ' || line[-1] == '\t'
        let line = line[0:-2]
    endwhile
    call setline('.', line . (strlen(line) == 0 ? '\\' : ' \\'))
endfunction
" nnoremap <buffer> <M-CR> :call AppendDoubleBackslash()<CR>o
inoremap <buffer> <M-CR> <Esc>:call AppendDoubleBackslash()<CR>o
" nnoremap <buffer> <M-Space> :call AppendDoubleBackslash()<CR>

" Preview
nnoremap <buffer> <Leader>m :write \| AsyncRun lxmake -d "$VIM_PREVIEW_HOME" "%:p" "$VIM_PREVIEW_HOME/vim-preview.pdf"<CR>
nnoremap <buffer> <Leader>M :write \| AsyncRun lxmake -md "$VIM_PREVIEW_HOME" "%:p" "$VIM_PREVIEW_HOME/vim-preview.pdf"<CR>
nnoremap <buffer> <Leader>.m :view $VIM_PREVIEW_HOME/vim-preview.log"<CR>:syn match Error '^\!.*'<CR>:syn match Boolean 'line [0-9]\+'<CR>:syn match Boolean 'l\.[0-9]\+'<CR>:syn match DbgBreakPt '.*[Ww]arning[^:]*:'<CR>GM
nnoremap <buffer> <Leader>p :AsyncRun setsid xdg-open "$VIM_PREVIEW_HOME/vim-preview.pdf"<CR>

" General snippets
inoremap <buffer> <Leader>p \paragraph{} <,,><C-o>F}
inoremap <buffer> <Leader>.p \subparagraph{} <,,><C-o>F}
inoremap <buffer> <Leader>s \section{}<Left>
inoremap <buffer> <Leader>.s \subsection{}<Left>
inoremap <buffer> <Leader>./s \subsubsection{}<Left>
inoremap <buffer> <Leader>a \section*{}<Left>
inoremap <buffer> <Leader>.a \subsection*{}<Left>
inoremap <buffer> <Leader>./a \subsubsection*{}<Left>
inoremap <buffer> <Leader>P \newpage
inoremap <buffer> <Leader>U \usepackage{}<Left>
inoremap <buffer> <Leader>.c \caption{}<Left>
inoremap <buffer> <Leader>.l \label{}<Left>
inoremap <buffer> <Leader>.r \ref{} <,,><C-o>F}
inoremap <buffer> <Leader>.f \footnote{\label{}<,,>} <,,><C-o>2F}
inoremap <buffer> <Leader>h \href{}{<,,>} <,,><C-o>2F}
inoremap <buffer> <Leader>i \emph{}<Left>
inoremap <buffer> <Leader>b \textbf{}<Left>
inoremap <buffer> <Leader>u \ul{}<Left>
inoremap <buffer> <Leader>~ \sim
inoremap <buffer> <Leader>^ \textasciicircum
inoremap <buffer> <Leader>\ \textbackslash
nmap <buffer> <Leader>B o<C-g>S\
imap <buffer> <Leader>B <C-g>S\

" Math snippets
inoremap <buffer> <Leader>e $$ <,,><C-o>F$
let num = 1
while num < 10
    let den = 1
    while den < 10
        execute 'inoremap <buffer> <Leader>'.num.den.' \frac{'.num.'}{'.den.'}'
        let den += 1
    endwhile
    let num += 1
endwhile
inoremap <buffer> <Leader>E \begin{equation*}<CR>\end{equation*}<C-o>O
inoremap <buffer> <Leader>A \begin{align*}<CR>\end{align*}<C-o>O
inoremap <buffer> <Leader>.E \begin{equation}<CR>\end{equation}<C-o>O
inoremap <buffer> <Leader>.A \begin{align}<CR>\end{align}<C-o>O
inoremap <buffer> <Leader>f \frac{}{<,,>} <,,><C-o>2F}
inoremap <buffer> <Leader>q \sqrt{} <,,><C-o>F}
inoremap <buffer> <Leader>.q \sqrt[]{<,,>} <,,><C-o>F]
inoremap <buffer> <Leader>* \cdot
inoremap <buffer> <Leader>M \begin{matrix}<CR>\end{matrix}<C-o>O
inoremap <buffer> <Leader>l \left
inoremap <buffer> <Leader>r \right
inoremap <buffer> <Leader>( \left(\right)<C-o>F\<CR><C-o>O
inoremap <buffer> <Leader>{ \left\{\right\}<C-o>2F\<CR><C-o>O
inoremap <buffer> <Leader>[ \left[\right]<C-o>F\<CR><C-o>O
inoremap <buffer> <Leader>< \left<\right><C-o>F\<CR><C-o>O<Tab>
inoremap <buffer> <Leader>\| \left\|\right\|<C-o>F\<CR><C-o>O<Tab>
inoremap <buffer> <Leader>x \text{}<Left>
inoremap <buffer> <Leader>gr \nabla 
inoremap <buffer> <Leader>S \mathbb{}<Left>
inoremap <buffer> <Leader>.. \ldots 
inoremap <buffer> <Leader>.+ \cup 
inoremap <buffer> <Leader>.* \cap 
inoremap <buffer> <Leader>& \land 
inoremap <buffer> <Leader>\| \lor 

" Figures
inoremap <buffer> <Leader>F \begin{figure}[H]<CR>\centering<CR>\includegraphics[width=\linewidth]{<,,>}<CR>\end{figure}<Esc>k$F\i
inoremap <buffer> <Leader>.F \begin{subfigure}[b]{\linewidth}<CR>\includegraphics[width=\linewidth]{<,,>}<CR>\end{subfigure}<Esc>2k$F\i
nnoremap <buffer> <Leader>is :call sshot#ImportScreenshot(function('sshot#LaTeXScreenshot'), '.png')<CR>
inoremap <buffer> <Leader>G \begin{figure}[H]<CR>\centering<CR>\digraph[scale=1.0]{}{<CR>rankdir=LR;<CR><,,><CR>}<CR>\end{figure}<Esc>4k$F}i
inoremap <buffer> <Leader>gl [label=<>];<Left><Left><Left>
inoremap <buffer> <Leader>g<CR> <BR/>

" Tables
inoremap <buffer> <Leader>tt \begin{longtable}[c]{\|\|}<CR>\hline<CR><,,><CR>\hline<CR>\endfirsthead<CR>\hline<CR><,,><CR>\hline<CR>\endhead<CR><,,><CR>\hline<CR>\end{longtable}<Esc>11k$hi
inoremap <buffer> <Leader>th \hline
inoremap <buffer> <Leader>tc \multicolumn{}{\|c\|}{<,,>}<,,><C-o>3F}
inoremap <buffer> <Leader>tr \multirow{}*{<,,>}<,,><C-o>2F}
inoremap <buffer> <M-Space> <Space>& 

" Lists
inoremap <buffer> <Leader>L \begin{itemize}<CR>\item <CR>\end{itemize}<Esc>kA
inoremap <buffer> <Leader>.L \begin{enumerate}<CR>\item <CR>\end{enumerate}<Esc>kA
inoremap <buffer> <Leader>D \begin{description}<CR>\item []<CR>\end{description}<Esc>k$i
inoremap <buffer> <Leader>.D \item []<CR>\begin{itemize}\item []<CR>\item <,,><CR>\end{itemize}<Esc>3ki
inoremap <buffer> <Leader>o \item 

" Code
inoremap <buffer> <Leader>C \begin{listing}[H]<CR>\begin{minted}[highlightlines={}]{}<CR><Tab><,,><CR>\end{minted}<CR>\end{listing}<Esc>3k$i
inoremap <buffer> <Leader>c \mintinline{}{<,,>}<C-o>2F}
inoremap <buffer> <Leader>v \texttt{}<Left>
inoremap <buffer> <Leader>.v \verb``<Left>

" Admonitions (ntheorem)
inoremap <buffer> <Leader>nn \begin{Note}<CR>\end{Note}<C-o>O
inoremap <buffer> <Leader>nw \begin{Warning}<CR>\end{Warning}<C-o>O
inoremap <buffer> <Leader>nc \begin{Caution}<CR>\end{Caution}<C-o>O
inoremap <buffer> <Leader>ni \begin{Important}<CR>\end{Important}<C-o>O
inoremap <buffer> <Leader>nt \begin{Theorem}<CR>\end{Theorem}<C-o>O
inoremap <buffer> <Leader>np \begin{Proof}<CR>\end{Proof}<C-o>O
inoremap <buffer> <Leader>nd \begin{Definition}<CR>\end{Definition}<C-o>O
inoremap <buffer> <Leader>nr \begin{Remark}<CR>\end{Remark}<C-o>O
inoremap <buffer> <Leader>nh \begin{Homework}<CR>\end{Homework}<C-o>O
inoremap <buffer> <Leader>ne \begin{Example}<CR>\end{Example}<C-o>O
inoremap <buffer> <Leader>nx \begin{Exercise}<CR>\end{Exercise}<C-o>O

" Shortcut for inserting a new subfile
function NewSubfileLatex()
    let filepath = expand('<cfile>')
    if empty(filepath)
        return 0
    endif
    let filepath = filepath.'.tex'

    if filepath[0] == '/'
        let mainpath = expand('%:p')
        let bufnr = bufadd(filepath)
    else
        let filedir = system(['dirname', '--', filepath])[0:-2]
        let mainpath = system([
            \'realpath', '--relative-to', expand('%:p:h').'/'.filedir,
            \'--', expand('%:p')])[0:-2]
        let bufnr = bufadd(expand('%:p:h').'/'.filepath)
    endif
    call setline('.', '\subfile{'.filepath.'}')
    write

    let lines = filereadable(filepath) ? [] : [
        \'%\def\UseGraphviz{}',
        \'%\def\UseMinted{}',
        \'\documentclass['.mainpath.']{subfiles}',
        \'',
        \'\begin{document}',
        \'',
        \'\end{document}']
    return [bufnr, lines]
endfunction
nnoremap <silent> <buffer> <Leader>if :silent let _newsubfile = NewSubfileLatex()<CR>
    \:silent if type(_newsubfile) == v:t_list \| call bufload(_newsubfile[0]) \|
    \ call setbufline(_newsubfile[0], 1, _newsubfile[1]) \|
    \ exec 'buf +6 '._newsubfile[0] \| endif<CR>

command LSPFileToggleTex    lua lsp_toggle({
            \   name = 'texlab',
            \   cmd  = {'texlab'},
            \   settings = require('lsp.settings.texlab'),
            \ })
command LSPProjectToggleTex lua lsp_toggle({
            \   name = 'texlab',
            \   cmd  = {'texlab'},
            \   settings = require('lsp.settings.texlab'),
            \ },
            \ {
            \  '.git',
            \  'main.tex', 'document.tex',
            \  'Makefile', 'makefile', 'GNUmakefile',
            \  'CMakeLists.txt'
            \ })
nnoremap <buffer> <silent> <Leader>l :LSPFileToggleTex<CR>
nnoremap <buffer> <silent> <Leader>L :LSPProjectToggleTex<CR>
