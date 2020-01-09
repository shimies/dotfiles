function! shimies#init#open_browser#hook_add() abort
    " Key-mappings {{{
    nnoremap [browser] <Nop>
    map <Space>o [browser]
    nmap [browser]o <Plug>(openbrowser-smart-search)
    vmap [browser]o <Plug>(openbrowser-smart-search)
    nnoremap <silent> [browser]c :<C-u>execute 'OpenBrowser' substitute('file:///' . expand('%:p'), ' ', '%20', 'g')<CR>
    " }}}
endfunction


function! shimies#init#open_browser#hook_source() abort
    let g:openbrowser_use_vimproc = 1
    if has('mac')
    elseif has('win64') || has('win32unix') || has('win32')
        let g:openbrowser_browser_commands = [
            \ { 'name': 'cmd', 'args': [ '{browser}', ' /c start firefox -private-window ', '{uri}' ] },
            \ { 'name': 'cmd', 'args': [ '{browser}', ' /c start chrome -incognito ', '{uri}' ] },
            \ { 'name': 'cmd', 'args': [ '{browser}', ' /c start iexplore -private ', '{uri}' ] },
            \ ]
    else
        let g:openbrowser_browser_commands = [
            \ { 'name': 'firefox', 'args': [ '{browser}', '-private-window', '{uri}' ] },
            \ { 'name': 'google-chrome', 'args': [ '{browser}', '-incognito', '{uri}' ] },
            \ ]
    endif
endfunction
