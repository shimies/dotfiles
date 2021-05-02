function! shimies#init#denite#hook_add() abort
    " Key-mappings {{{
    nnoremap [denite] <Nop>
    nmap <Space>u [denite]

    " Display previous target once again
    nnoremap <silent> [denite]R :<C-u>Denite -resume<CR>
    " Explorer
    " Launch with file list placed on the directory of current buffer
    nnoremap <silent> [denite]e :<C-u>DeniteBufferDir -buffer-name=files file<CR>
    " Buffers
    nnoremap <silent> [denite]b :<C-u>Denite buffer<CR>
    " Registers
    nnoremap <silent> [denite]r :<C-u>Denite register<CR>
    " Tabs
    " nnoremap <silent> [denite]t :<C-u>Denite tab<CR>
    " Bookmarks
    " nnoremap <silent> [denite]m :<C-u>Denite bookmark<CR>
    " Key-map
    " nnoremap <silent> [denite]k :<C-u>Denite mapping<CR>
    " Project
    nnoremap <silent> [denite]p :<C-u>Denite file_rec/async<CR>
    " Git
    nnoremap <silent> [denite]g :<C-u>Denite file_rec/git:--cached:--others:--exclude-standard<CR>
    " Included files
    nnoremap <silent> [denite]i :<C-u>Denite file_include<CR>

    " menu
    nnoremap [menu] <Nop>
    nmap <Space>m [menu]

    nnoremap [menu] :<C-u>Denite menu
    nnoremap <silent> [menu]t :<C-u>Denite menu:toggle<CR>
    nnoremap <silent> [menu]s :<C-u>Denite menu:shortcut<CR>
    " }}}
endfunction


function! shimies#init#denite#hook_post_source() abort
    " Add custom menus {{{
    let s:menus = {}

    " menu:shortcut
    let s:menus.shortcut = {}
    let s:menus.shortcut.description = 'Run shortcut commands'
    let s:menus.shortcut.command_candidates = [
        \ ['[browser] Boost libs'    , 'OpenBrowser http://www.boost.org/doc/libs/'],
        \ ['[browser] Boost.MPL libs', 'OpenBrowser http://www.boost.org/doc/libs/release/libs/mpl/doc/refmanual/refmanual_toc.html'],
        \ ['[browser] ideone.com'    , 'OpenBrowser http://ideone.com/'],
        \ ['[shell] bc'              , 'VimShellInteractive bc -l'],
        \ ['[shell] clisp'           , 'VimShellInteractive clisp'],
        \ ['[shell] ghci'            , 'VimShellInteractive ghci'],
        \ ['[shell] gnuplot'         , 'VimShellInteractive gnuplot'],
        \ ['[shell] python'          , 'VimShellInteractive python'],
        \ ['[shell] VimShellPop'     , 'VimShellPop'],
        \ ]

    " menu:toggle
    let s:menus.toggle = {}
    let s:menus.toggle.description = 'Invert toggle options'
    let s:menus.toggle.command_candidates = []
    for s:option in ['expandtab', 'hlsearch', 'list', 'number', 'relativenumber', 'spell', 'wrap']
        call add(s:menus.toggle.command_candidates, [s:option, 'ToggleOption ' . s:option])
    endfor

    call denite#custom#var('menu', 'menus', s:menus)
    " }}}

    augroup myvimrc-denite
        autocmd!
        autocmd FileType denite call s:denite_my_settings()
        autocmd FileType denite-filter call s:denite_filter_my_settings()
    augroup END

    function! s:denite_my_settings()
        nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
        nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
        nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
        nnoremap <silent><buffer><expr> q denite#do_map('quit')
        nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
        nnoremap <silent><buffer><expr> @ denite#do_map('toggle_select')
    endfunction

    function! s:denite_filter_my_settings() abort
        imap <silent><buffer> <C-d> <Plug>(denite_filter_quit)
    endfunction
endfunction
