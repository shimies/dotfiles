function! shimies#init#jedi_vim#hook_source() abort
    nnoremap [jedi] <Nop>
    nmap <Space>j [jedi]

    let g:jedi#auto_initialization = 1
    let g:jedi#goto_assignments_command = '[jedi]g'
    let g:jedi#goto_command = '[jedi]d'
    let g:jedi#rename_command = '[jedi]r'
    let g:jedi#usages_command = '[jedi]n'

    augroup python-jedi-vim
        autocmd!
        autocmd FileType python setlocal omnifunc=jedi#completions
    augroup END
endfunction
