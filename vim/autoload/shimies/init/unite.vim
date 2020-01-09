function! shimies#init#unite#hook_add() abort
    " Key-mappings {{{
    nnoremap [unite] <Nop>
    nmap <Space>u [unite]

    " Display previous target once again
    nnoremap <silent> [unite]R :<C-u>UniteResume<CR>
    " Explorer
    " Launch with file list placed on the directory of current buffer
    nnoremap <silent> [unite]e :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
    " Buffers
    nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
    " Registers
    nnoremap <silent> [unite]r :<C-u>Unite register<CR>
    " Tabs
    nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
    " Bookmarks
    nnoremap <silent> [unite]m :<C-u>Unite bookmark<CR>
    " Key-map
    nnoremap <silent> [unite]k :<C-u>Unite mapping<CR>
    " Project
    nnoremap <silent> [unite]p :<C-u>Unite file_rec/async<CR>
    " Git
    nnoremap <silent> [unite]g :<C-u>Unite file_rec/git:--cached:--others:--exclude-standard<CR>
    " Included files
    nnoremap <silent> [unite]i :<C-u>Unite file_include<CR>

    " menu
    nnoremap [menu] <Nop>
    nmap <Space>m [menu]

    nnoremap [menu] :<C-u>Unite menu
    nnoremap <silent> [menu]t :<C-u>Unite menu:toggle<CR>
    nnoremap <silent> [menu]s :<C-u>Unite menu:shortcut<CR>
    " }}}
endfunction


function! shimies#init#unite#hook_post_source() abort
    let g:unite_enable_start_insert = 0

    call unite#custom_source('bookmark', 'sorters', 'sorter_word')
    call unite#custom_source('menu', 'sorters', 'sorter_word')

    " unite-source-menu {{{
    let g:unite_source_menu_menus = {}

    " menu:shortcut
    let g:unite_source_menu_menus.shortcut = {}
    let g:unite_source_menu_menus.shortcut.description = 'Run shortcut commands'
    let g:unite_source_menu_menus.shortcut.command_candidates = {
        \ '[browser] Boost libs'    : 'OpenBrowser http://www.boost.org/doc/libs/',
        \ '[browser] Boost.MPL libs': 'OpenBrowser http://www.boost.org/doc/libs/release/libs/mpl/doc/refmanual/refmanual_toc.html',
        \ '[browser] ideone.com'    : 'OpenBrowser http://ideone.com/',
        \ '[shell] bc'              : 'VimShellInteractive bc -l',
        \ '[shell] clisp'           : 'VimShellInteractive clisp',
        \ '[shell] ghci'            : 'VimShellInteractive ghci',
        \ '[shell] gnuplot'         : 'VimShellInteractive gnuplot',
        \ '[shell] python'          : 'VimShellInteractive python',
        \ '[shell] VimShellPop'     : 'VimShellPop',
        \ }

    " menu:toggle
    let g:unite_source_menu_menus.toggle = {}
    let g:unite_source_menu_menus.toggle.description = 'Invert toggle options'
    let g:unite_source_menu_menus.toggle.command_candidates = {}

    for s:option in [ 'expandtab', 'hlsearch', 'list', 'number', 'relativenumber', 'spell', 'wrap' ]
        let g:unite_source_menu_menus.toggle.command_candidates[s:option] = 'ToggleOption ' . s:option
    endfor
    " }}}

    augroup myvimrc-unite
        autocmd!
        autocmd FileType unite call s:unite_my_settings()
    augroup END

    function! s:unite_my_settings()
        " Exchange <Space> into @
        " i.e. <Space> is not available as marking key
        nmap <buffer> <Space> <Space>
        nmap <buffer> @ <Plug>(unite_toggle_mark_current_candidate)

        " Disable <S-Space>
        nmap <buffer> <S-Space> <S-Space>

        " Use U to clear cache for candidates
        nmap <buffer> U <Plug>(unite_redraw)
    endfunction
endfunction
