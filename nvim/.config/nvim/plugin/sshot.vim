" Functions for taking screenshots in various markup languages.
" Heavily inspired by Gavin Freeborn's vim configuration,
" see <https://github.com/Gavinok/dotvim/blob/master/autoload/dotvim.vim>

" Markdown
function! sshot#MarkdownScreenshot(imgpath)
    if strlen(getline('.')) > 0
        call append('.', '![image]('.a:imgpath.')')
    else
        call setline('.', '![image]('.a:imgpath.')')
    endif
endfunction

" LaTeX
function! sshot#LaTeXScreenshot(imgpath)
    if strlen(getline('.')) > 0
        call append('.', '\includegraphics[width=\linewidth]{'.a:imgpath.'}')
    else
        call setline('.', '\includegraphics[width=\linewidth]{'.a:imgpath.'}')
    endif
endfunction

" Asciidoc
function! sshot#AsciidocScreenshot(imgpath)
    if strlen(getline('.')) > 0
        call append('.', 'image::'.a:imgpath.'[]')
    else
        call setline('.', 'image::'.a:imgpath.'[]')
    endif
endfunction

" NeatRoff
function! sshot#NeatRoffScreenshot(imgpath)
    let ntpdfsp = expand('~').'/.scripts/ntpdfsp'
    let newline = system(ntpdfsp." '".a:imgpath."'")
    if v:shell_error
        echo 'NeatRoffScreenshot: failed to run ntpdfsp'
        return
    endif
    if strlen(getline('.')) > 0
        call append('.', newline)
    else
        call setline('.', newline)
    endif
endfunction

" Driver function for all screenshot types
function! sshot#ImportScreenshot(screenshotfunc, extension)
    let img_dir = expand('%:p:h').'/img/'
    let filename = input('Input filename: ')
    redraw
    if strlen(filename) == 0
        echo 'Empty filename, skipping.'
        return
    endif
    let filename = substitute(filename, ' ', '_', 'g').a:extension
    if !isdirectory(img_dir)
        call mkdir(img_dir)
    endif
    let overwrite = 1
    if filereadable(img_dir.filename)
        let overwrite = 0
        let ans = input('File already exists. Overwrite? [y/N] ')
        redraw
        if ans == 'y' || ans == 'Y'
            let overwrite = 1
        endif
    endif
    if overwrite
        call system('xclip -selection clipboard -t TARGETS -o | grep -q image/png')
        if v:shell_error
            echo 'No image in clipboard detected'
            return
        endif
        call system('xclip -selection clipboard -t image/png -o | convert - "'.img_dir.filename.'"')
        if v:shell_error
            echo 'ImportScreenshot: failed to save screenshot'
            return
        endif
    endif
    lcd %:p:h
    call a:screenshotfunc('img/'.filename)
    lcd -
endfunction
