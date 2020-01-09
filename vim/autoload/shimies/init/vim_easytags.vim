function! shimies#init#vim_easytags#hook_source() abort
    let g:easytags_cmd = expand('$HOME/.local/bin/ctags')
    let g:easytags_async = 1
    let g:easytags_events = [ 'BufWritePost' ]
    let g:easytags_file = expand('$HOME/.cache/vim/easytags')
    let g:easytags_auto_update = 1

    let g:easytags_languages = {
        \ 'verilog_systemverilog': {
        \     'cmd': g:easytags_cmd,
        \     'args': ['--extras=+q', '--fields=+i'],
        \     'fileoutput_opt': '-f',
        \     'stdout_opt': '-f-',
        \     'recurse_flag': '-R',
        \ },
        \ }
    let g:easytags_languages['verilog'] = g:easytags_languages['verilog_systemverilog']
endfunction
