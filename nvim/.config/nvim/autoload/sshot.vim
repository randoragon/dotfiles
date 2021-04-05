" Functions for taking screenshots in various markup languages.
" Heavily inspired by Gavin Freeborn's vim configuration,
" see <https://github.com/Gavinok/dotvim/blob/master/autoload/dotvim.vim>

" Markdown
function! sshot#MarkdownScreenshot(desc, dir, filename)
    call setline('.', '!['.a:desc.']('.a:dir.'/'.a:filename.')')
endfunction

" NeatRoff
function! sshot#NeatRoffScreenshot(desc, dir, filename)
    let ntpdfsp = expand('~')."/.scripts/ntpdfsp"
    let imgpath = a:dir.'/'.a:filename
    call append(line('.') - 1, system(ntpdfsp." '".imgpath."'"))
    if v:shell_error
        echo "NeatRoffScreenshot: failed to run ntpdfsp"
        call setline('.', a:desc)
        return
    endif
    call setline('.', printf("\\X'pdf ".'%s/%s'." \\n(.l'", a:dir, a:filename))
    call append('.', printf(".br"))
endfunction

" Driver function for all screenshot types
function! sshot#ImportScreenshot(screenshotfunc, extension)
    let rel_dir = expand('%:h').'/img'
    let abs_dir = expand('%:p:h').'/'.rel_dir
    let desc = getline('.')
    if strlen(desc) == 0
        echo "ImportScreenshot: empty filename"
        return
    endif
    let filename = substitute(getline('.'), ' ', '_', 'g').a:extension
    if filereadable(abs_dir.'/'.filename)
        echo "ImportScreenshot: file already exists"
        return
    endif
    if !isdirectory(abs_dir)
        call mkdir(abs_dir)
    endif
    call system('shotgun -g "$(xrectsel)" - | convert - "'.abs_dir.'/'.filename.'"')
    if v:shell_error
        echo "ImportScreenshot: failed to save screenshot"
        call setline('.', desc)
        return
    endif
    call a:screenshotfunc(desc, rel_dir, filename)
endfunction
