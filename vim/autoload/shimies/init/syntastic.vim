function! shimies#init#syntastic#hook_add() abort
    " Key-mappings {{{
    nnoremap [syntax] <Nop>
    nmap <Space>x [syntax]

    nnoremap <silent> [syntax]x :<C-u>Errors<CR>
    nnoremap <silent> [syntax]c :<C-u>SyntasticCheck<CR>
    nnoremap <silent> [syntax]t :<C-u>SyntasticToggleMode<CR>
    nnoremap <silent> [syntax]r :<C-u>SyntasticReset<CR>
    " }}}
endfunction


function! shimies#init#syntastic#hook_source() abort
    let g:syntastic_enable_signs = 1
    let g:syntastic_enable_highlighting = 0
    let g:syntastic_auto_loc_list = 2
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_mode_map = { 'mode': 'passive' }

    let g:syntastic_c_compiler = 'gcc'
    let g:syntastic_c_compiler_options = '-std=gnu99'
    if executable('g++-4.7') || executable('g++-4.8') || executable('g++-4.9')
        let g:syntastic_cpp_compiler = 'g++'
        let g:syntastic_cpp_compiler_options = '-std=c++11'
    else
        let g:syntastic_cpp_compiler = 'g++'
        let g:syntastic_cpp_compiler_options = '-std=c++0x'
    endif
endfunction
