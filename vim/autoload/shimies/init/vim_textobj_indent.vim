function! shimies#init#vim_textobj_indent#hook_source() abort
    let g:textobj_indent_no_default_key_mappings = 1
    vmap ai <Plug>(textobj-indent-a)
    omap ai <Plug>(textobj-indent-a)
    vmap ii <Plug>(textobj-indent-i)
    omap ii <Plug>(textobj-indent-i)
    vmap aI <Plug>(textobj-indent-same-a)
    omap aI <Plug>(textobj-indent-same-a)
    vmap iI <Plug>(textobj-indent-same-i)
    omap iI <Plug>(textobj-indent-same-i)
endfunction
