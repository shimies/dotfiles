function! shimies#init#neosnippet#hook_source() abort
    let g:neosnippet#disable_runtime_snippets = {
        \ 'tex'   : 1,
        \ }
    let g:neosnippet#snippets_directory = $MYVIMHOME . '/snippets'

    let g:neosnippet#scope_aliases = {}
    let g:neosnippet#scope_aliases['verilog_systemverilog'] = 'verilog'

    " For snippet_complete marker.
    " if has('conceal')
    "     set conceallevel=2 concealcursor=i
    " endif

    " Key-mappings {{{
    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)
    xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)

    " SuperTab like snippets' behavior.
    imap <expr> <TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr> <TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    " imap <expr> <TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
    " smap <expr> <TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : "\<TAB>"
    " }}}
endfunction
