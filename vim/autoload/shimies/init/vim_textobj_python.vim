function! shimies#init#vim_textobj_python#hook_source() abort
    let g:textobj_python_no_default_key_mappings = 1
    call textobj#user#map('python', {
        \ 'class': {
        \     'select-a': '<buffer>ac',
        \     'select-i': '<buffer>ic',
        \     'move-n': '<buffer>]pc',
        \     'move-p': '<buffer>[pc',
        \ },
        \ 'function': {
        \     'select-a': '<buffer>af',
        \     'select-i': '<buffer>if',
        \     'move-n': '<buffer>]pf',
        \     'move-p': '<buffer>[pf',
        \ }
        \ })
endfunction
