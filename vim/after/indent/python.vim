if exists("b:did_after_indent")
    finish
endif
let b:did_after_indent = 1

setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal smarttab
setlocal foldmethod=indent
