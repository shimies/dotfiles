function! shimies#init#vimproc#hook_post_update() abort
    if has('win32unix')
        let cmd = 'make -f make_cygwin.mak'
    elseif dein#util#_is_windows()
        let cmd = 'tools\\update-dll-mingw'
    elseif dein#util#_is_mac()
        let cmd = 'make -f make_mac.mak'
    elseif executable('gmake')
        let cmd = 'gmake'
    else
        let cmd = 'make'
    endif
    let g:dein#plugin.build = cmd
endfunction
