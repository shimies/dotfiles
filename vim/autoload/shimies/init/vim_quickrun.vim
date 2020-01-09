function! shimies#init#vim_quickrun#hook_source() abort
    let g:quickrun_config = {
        \ '_': {
        \     'outputter/buffer/split': ':belowright 8sp',
        \     'outputter/buffer/close_on_empty': 0,
        \     'runner': 'vimproc',
        \     'runner/vimproc/updatetime': 10,
        \ },
        \ 'c': {
        \     'command': 'gcc',
        \     'cmdopt': '-Wall -Wl,--no-as-needed -lm -std=gnu99',
        \ },
        \ 'c/opencv': {
        \     'type': 'c',
        \     'cmdopt': '-Wall -Wl,--no-as-needed `pkg-config --libs --cflags opencv` -std=gnu99',
        \ },
        \ 'cpp': {
        \     'command': 'g++',
        \     'cmdopt': '-Wall -std=c++11',
        \ },
        \ 'cpp/opencv': {
        \     'type': 'cpp',
        \     'cmdopt': '-Wall -Wl,--no-as-needed `pkg-config --libs --cflags opencv` -std=c++11',
        \ },
        \ 'verilog': {
        \     'command': 'iverilog',
        \     'exec': ['%c %o %s -o %s:p:r', '%s:p:r %a'],
        \     'cmdopt': '-g2005',
        \     'tempfile': '%{tempname()}.v',
        \     'hook/sweep/files': '%S:p:r',
        \ },
        \ 'verilog_systemverilog': {
        \     'type': 'verilog',
        \ },
        \ }

    " Key-mappings {{{
    nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
    " }}}
endfunction

