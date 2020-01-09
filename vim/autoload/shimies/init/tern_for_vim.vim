function! shimies#init#tern_for_vim#hook_source() abort
    let g:tern#command = ['nodejs', expand('<sfile>:h') . '/../node_modules/tern/bin/tern', '--no-port-file']
    nnoremap [tern] <Nop>
    nmap <Space>t [tern]

endfunction
