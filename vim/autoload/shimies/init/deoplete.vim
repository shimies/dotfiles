function! shimies#init#deoplete#hook_source() abort
    " Use deoplete
    let g:deoplete#enable_at_startup = 1

    " Configures on behavior
    let g:deoplete#min_pattern_length = 0

    " Usual completion features
    let g:deoplete#enable_ignore_case = 1
    let g:deoplete#enable_smart_case = 1
    let g:deoplete#enable_camel_case = 0

    " " For completion that is heavy and have many candidates
    let g:deoplete#max_list = 1000

    " " Omni completion
    let g:deoplete#omni_patterns = {}
    let g:deoplete#omni_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

    " " Key-mappings {{{
    " inoremap <expr> <C-g> deoplete#undo_completion()
    " inoremap <expr> <C-l> deoplete#complete_common_string()

    " " <TAB>: completion.
    " inoremap <expr> <Tab> deoplete#complete_common_string() != '' ? deoplete#complete_common_string() : pumvisible() ? "\<C-n>" : "\<Tab>"
    " inoremap <expr> <S-Tab> deoplete#complete_common_string() != '' ? deoplete#complete_common_string() : pumvisible() ? "\<C-p>" : "\<S-Tab>"
    " " }}}
endfunction
