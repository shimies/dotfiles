function! shimies#init#vim_javacomplete2#hook_source() abort
    let g:JaveComplete_AutoStartServer = 1
    let g:JavaComplete_EnableDefaultMappings = 0
    let g:JavaComplete_UsePython3 = 1

    augroup java-javacomplete2
        autocmd!
        autocmd FileType java setlocal omnifunc=javacomplete#Complete
        autocmd FileType java setlocal completefunc=javacomplete#CompleteParamsInfo
    augroup END
endfunction
