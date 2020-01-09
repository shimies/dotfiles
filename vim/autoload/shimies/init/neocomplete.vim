function! shimies#init#neocomplete#hook_source() abort
    " Use neocomplete
    let g:neocomplete#enable_at_startup = 1

    " Configures on behavior
    let g:neocomplete#enable_auto_select = 0
    let g:neocomplete#auto_completion_start_length = 0
    let g:neocomplete#manual_completion_start_length = 0
    let g:neocomplete#enable_auto_delimiter = 0

    " Usual completion features
    let g:neocomplete#enable_ignore_case = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_camel_case = 0

    " For completion that is heavy and have many candidates
    let g:neocomplete#skip_auto_completion_time = ''
    let g:neocomplete#max_list = 1000

    " Minimum keyword length for cache
    let g:neocomplete#min_keyword_length = 2

    " Buffer name pattern not to complete automatically
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define keyword
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns._ = '\h\w*'

    " Omni completion
    if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns = {
        \ 'c': '[^.[:digit:] *\t]\%(\.\|->\)\w*',
        \ 'cpp': '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*',
        \ 'objc': '\[\h\w*\s\h\?\|\h\w*\%(\.\|->\)',
        \ 'objcpp': '\[\h\w*\s\h\?\|\h\w*\%(\.\|->\)\|\h\w*::\w*',
        \ 'java': '[^.[:digit:] *\t]\%(\.\)\%(\h\w*\)\?',
        \ 'php': '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?',
        \ 'python': '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*',
        \ 'javascript': '[^.[:digit:] *\t]\%(\.\)\%(\h\w*\)\?',
        \ 'ocaml': '[^. *\t]\.\w*\|\h\w*|#',
        \ 'verilog_systemverilog': '[^.[:digit:] *\t]\%(\.\|->\)\w*',
        \ }

    " Key-mappings {{{
    inoremap <expr> <C-g> neocomplete#undo_completion()
    inoremap <expr> <C-l> neocomplete#complete_common_string()

    " <TAB>: completion.
    inoremap <expr> <Tab> neocomplete#complete_common_string() != '' ? neocomplete#complete_common_string() : pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> neocomplete#complete_common_string() != '' ? neocomplete#complete_common_string() : pumvisible() ? "\<C-p>" : "\<S-Tab>"
    " }}}
endfunction
