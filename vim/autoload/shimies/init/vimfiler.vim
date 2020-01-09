function! shimies#init#vimfiler#hook_add() abort
    " Key-mappings  {{{
    nnoremap [vimfiler] <Nop>
    nmap <Space>f [vimfiler]

    nnoremap <silent> [vimfiler]v :<C-u>VimFiler<CR>
    nnoremap <silent> [vimfiler]b :<C-u>VimFilerBufferDir<CR>
    nnoremap <silent> [vimfiler]d :<C-u>VimFilerDouble<CR>
    nnoremap <silent> [vimfiler]e :<C-u>VimFilerExplorer -winwidth=25<CR>
    nnoremap <silent> [vimfiler]f :<C-u>VimFilerExplorer -find -winwidth=25<CR>
    nnoremap <silent> [vimfiler]t :<C-u>VimFilerTab<CR>
    " }}}
endfunction

function! shimies#init#vimfiler#hook_source() abort
    let g:unite_kind_file_use_trashbox = 0

    augroup myvimrc-vimfiler
        autocmd!
        autocmd FileType vimfiler call s:vimfiler_my_settings()
    augroup END

    function! s:vimfiler_my_settings()
        " Disable line number feature
        setlocal nonumber

        " Exchange q into Q
        nmap <buffer> q <Plug>(vimfiler_exit)
        nmap <buffer> Q <Plug>(vimfiler_hide)

        " Exchange <Space> into @
        " i.e. <Space> is not available as marking key
        nmap <buffer> <Space> <Space>
        nmap <buffer> @ <Plug>(vimfiler_toggle_mark_current_line)
    endfunction
endfunction
