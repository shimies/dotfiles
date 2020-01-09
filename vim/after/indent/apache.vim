if exists("b:did_after_indent")
    finish
endif
let b:did_after_indent = 1

" local settings (must come before aborting the script)
setlocal indentexpr=ApacheIndentGet(v:lnum,1)
setlocal indentkeys=o,O,*<CR>,<>>,{,}

set cpoptions-=C

" finish, if the function already exists
if exists('*ApacheIndentGet')
    finish
endif

function! ApacheIndentGet(lnum, use_syntax_check)
    " Find a non-empty line above the current line.
    let lnum = prevnonblank(a:lnum - 1)

    " Hit the start of the file, use zero indent.
    if lnum == 0
        return 0
    endif

    let prevline = getline(lnum)
    let line = getline(a:lnum)
    let ind = indent(lnum)
    let inddelta = 0
    if match(line, '^\s*</') == 0
        "if this is a closing tag line, reduce its indentation
        let inddelta = 0 - &l:shiftwidth
    elseif match(prevline,'^\s*<\a') == 0
        "if previous line is a opening tag line, increase its indentation
        let inddelta = &l:shiftwidth
    endif

    let ind = ind + inddelta

    return ind
endfunction

" http://labs.timedia.co.jp/2011/04/9-points-to-customize-automatic-indentation-in-vim.html
