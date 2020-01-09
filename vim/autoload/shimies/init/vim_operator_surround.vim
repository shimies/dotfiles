function! shimies#init#vim_operator_surround#hook_source() abort
    nmap <silent>ys <Plug>(operator-surround-append)
    nmap <silent>ds <Plug>(operator-surround-delete)
    nmap <silent>cs <Plug>(operator-surround-replace)
    nmap <silent>yss V<Plug>(operator-surround-append)
    nmap <silent>dss V<Plug>(operator-surround-delete)
    nmap <silent>css V<Plug>(operator-surround-replace)
    vmap <silent>S <Plug>(operator-surround-append)
endfunction
