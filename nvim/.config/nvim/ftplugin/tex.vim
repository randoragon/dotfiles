set textwidth=80
set tabstop=4 shiftwidth=4
inoremap <buffer> <M-p> <Esc>/<,,><CR>"_cf>
nnoremap <buffer> <M-CR> A\\<CR>
inoremap <buffer> <M-CR> <C-o>A\\<CR>

" Preview
nnoremap <buffer> <Leader>m :write \| AsyncRun lxmake -d "${XDG_CACHE_HOME:-~/.cache}" "%:p" "${XDG_CACHE_HOME:-~/.cache}/vim-preview.pdf"<CR>
nnoremap <buffer> <Leader>.m :view $HOME/.cache/vim-preview.log"<CR>:syn match Error '^\!.*'<CR>:syn match Boolean 'line [0-9]\+'<CR>:syn match Boolean 'l\.[0-9]\+'<CR>:syn match DbgBreakPt '.*[Ww]arning[^:]*:'<CR>GM
nnoremap <buffer> <Leader>p :AsyncRun setsid xdg-open "${XDG_CACHE_HOME:-~/.cache}/vim-preview.pdf"<CR>

" General snippets
inoremap <buffer> <Leader>p \paragraph{} <,,><C-o>F}
inoremap <buffer> <Leader>.p \subparagraph{} <,,><C-o>F}
inoremap <buffer> <Leader>s \section{}<Left>
inoremap <buffer> <Leader>.s \subsection{}<Left>
inoremap <buffer> <Leader>./s \subsubsection{}<Left>
inoremap <buffer> <Leader>P \newpage
inoremap <buffer> <Leader>U \usepackage{}<Left>
inoremap <buffer> <Leader>.c \caption{}<Left>
inoremap <buffer> <Leader>.l \label{}<Left>
inoremap <buffer> <Leader>.r \ref{} <,,><C-o>F}
inoremap <buffer> <Leader>.f \footnote{\label{}<,,>} <,,><C-o>2F}
inoremap <buffer> <Leader>h \href{}{<,,>} <,,><C-o>2F}
inoremap <buffer> <Leader>i \emph{}<Left>
inoremap <buffer> <Leader>b \textbf{}<Left>
inoremap <buffer> <Leader>u \underline{}<Left>
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
inoremap <buffer> <Leader>.q \sqrt[]{<,,>} <,,><C-o>F]
inoremap <buffer> <Leader>* \cdot
inoremap <buffer> <Leader>M \begin{matrix}<CR>\end{matrix}<C-o>O
inoremap <buffer> <Leader>l \left
inoremap <buffer> <Leader>r \right
inoremap <buffer> <Leader>( \left(<CR>\right)<C-o>O
inoremap <buffer> <Leader>{ \left\{<CR>\right\}<C-o>O
inoremap <buffer> <Leader>[ \left[<CR>\right]<C-o>O
inoremap <buffer> <Leader>< \left<<CR>\right><C-o>O

" Figures
inoremap <buffer> <Leader>F \begin{figure}[h!]<CR>\centering<CR>\includegraphics[width=\linewidth]{}<CR>\caption{<,,>}<CR>\end{figure}<Esc>4k$i
inoremap <buffer> <Leader>.F \begin{subfigure}[b]{\linewidth}<CR>\includegraphics[width=\linewidth]{<,,>}<CR>\caption{<,,>}<CR>\end{subfigure}<Esc>3k$F\i

" Tables
inoremap <buffer> <Leader>tt \begin{longtable}[c]{}<CR><,,><CR>\endfirsthead<CR><,,><CR>\endhead<CR><,,><CR>\end{longtable}<Esc>6k$i
inoremap <buffer> <Leader>th \hline
inoremap <buffer> <Leader>tc \multicolumn{}{c\|}{<,,>} <,,><C-o>3F}
inoremap <buffer> <Leader>tr \multirow{}*{<,,>} <,,><C-o>2F}

" Lists
inoremap <buffer> <Leader>L \begin{itemize}<CR>\item <CR>\end{itemize}<Esc>kA
inoremap <buffer> <Leader>.L \begin{enumerate}<CR>\item <CR>\end{enumerate}<Esc>kA
inoremap <buffer> <Leader>I \item 

" Code
inoremap <buffer> <Leader>C \begin{listing}[h!]<CR>\begin{minted}[highlightlines={}]{}<CR><Tab><,,><CR>\end{minted}<CR>\end{listing}<Esc>3k$i
inoremap <buffer> <Leader>c \mintinline{}{<,,>}<C-o>2F}
inoremap <buffer> <Leader>v \texttt{}<Left>
