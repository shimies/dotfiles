function! shimies#init#verilog_systemverilog#hook_source() abort
    " let g:verilog_quick_syntax = 0
    let g:verilog_disable_indent_lst = 'class,interface,module,eos'

    " Key-mappings  {{{
    nnoremap [verilog] <Nop>
    nmap <Space>v [verilog]
    nnoremap <silent> [verilog]i :<C-u>VerilogFollowInstance<CR>
    nnoremap <silent> [verilog]I :<C-u>VerilogFollowPort<CR>
    nnoremap <silent> [verilog]u :<C-u>VerilogGotoInstanceStart<CR>
    " }}}
endfunction
