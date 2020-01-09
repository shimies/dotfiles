function! shimies#init#vim_quickhl#hook_add() abort
    " Key-mappings {{{
    nnoremap [quickhl] <Nop>
    map <Space>h [quickhl]

    nmap [quickhl]h <Plug>(quickhl-manual-this)
    xmap [quickhl]h <Plug>(quickhl-manual-this)
    nmap [quickhl]r <Plug>(quickhl-manual-reset)
    xmap [quickhl]r <Plug>(quickhl-manual-reset)
    nmap [quickhl]e <Plug>(quickhl-manual-toggle)
    xmap [quickhl]e <Plug>(quickhl-manual-toggle)
    nmap [quickhl]c <Plug>(quickhl-cword-toggle)
    nnoremap [quickhl]l :<C-u>QuickhlManualList<CR>
    " }}}
endfunction


function! shimies#init#vim_quickhl#hook_source() abort
    let g:quickhl_manual_enable_at_startup = 1
    " let g:quickhl_cword_enable_at_startup = 1
    " let g:quickhl_tag_enable_at_startup = 1
endfunction
