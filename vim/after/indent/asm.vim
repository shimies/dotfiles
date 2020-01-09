if exists("b:did_after_indent")
    finish
endif
let b:did_after_indent = 1

setlocal indentkeys-=:

setlocal noexpandtab
setlocal tabstop=8
setlocal softtabstop=8
setlocal shiftwidth=8
