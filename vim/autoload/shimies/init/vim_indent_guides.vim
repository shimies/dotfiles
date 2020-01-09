function! shimies#init#vim_indent_guides#hook_source() abort
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_exclude_filetypes = [ 'help', 'nerdtree', 'calendar' ]

    if has('gui_running')
        let g:indent_guides_auto_colors = 1
    else
        let g:indent_guides_auto_colors = 0
        augroup myvimrc-indent-guides
            autocmd!
            autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=Black
            autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=DarkGray
        augroup END
    endif
endfunction
