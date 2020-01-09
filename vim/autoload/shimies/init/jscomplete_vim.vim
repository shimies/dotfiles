function! shimies#init#jscomplete_vim#hook_source() abort
    augroup javascript-jscomplete-vim
        autocmd!
        autocmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS
    augroup END
endfunction
