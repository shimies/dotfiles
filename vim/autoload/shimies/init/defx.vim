function! shimies#init#defx#hook_add() abort
    " Key-mappings  {{{
    nnoremap [defx] <Nop>
    nmap <Space>f [defx]

    nnoremap <silent> [defx]d :<C-u>Defx<CR>
    nnoremap <silent> [defx]e :<C-u>Defx -split=vertical -winwidth=35 -direction=topleft<CR>
    nnoremap <silent> [defx]f :<C-u>Defx -split=vertical -winwidth=35 -direction=topleft -search=`expand('%:p')`<CR>
    nnoremap <silent> [defx]t :<C-u>Defx -split=tab -buffer-name=`'defx-tab' . tabpagenr()`<CR>
    " }}}
endfunction

function! shimies#init#defx#hook_source() abort
    augroup myvimrc-defx
        autocmd!
        autocmd FileType defx call s:defx_my_settings()
    augroup END

    function! s:defx_my_settings() abort
        " Disable line number feature
        setlocal nonumber

        " Define mappings for defx controls
        nnoremap <silent><buffer><expr> h defx#do_action('close_tree')
        nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
        nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
        nnoremap <silent><buffer><expr> l defx#is_directory() ? (defx#is_opened_tree() ? 'j' : defx#do_action('open_tree')) : defx#do_action('drop')
        nnoremap <silent><buffer><expr> <BS> defx#do_action('cd', ['..'])
        nnoremap <silent><buffer><expr> <C-l> defx#do_action('redraw')
        nnoremap <silent><buffer><expr> <C-g> defx#do_action('print') . 'j'
        nnoremap <silent><buffer><expr> C defx#do_action('toggle_columns', 'mark:indent:icon:filename:type:size:time')
        nnoremap <silent><buffer><expr> S defx#do_action('toggle_sort', 'time')
        nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
        nnoremap <silent><buffer><expr> q defx#do_action('quit')
        nnoremap <silent><buffer><expr> @ defx#do_action('toggle_select')
        nnoremap <silent><buffer><expr> * defx#do_action('toggle_select_all')
        nnoremap <silent><buffer><expr> U defx#do_action('clear_select_all')

        " Define mappings for file manipulations
        nnoremap <silent><buffer><expr> <CR> defx#do_action('drop')
        nnoremap <silent><buffer><expr> o defx#do_action('open', 'vsplit')
        nnoremap <silent><buffer><expr> c defx#do_action('copy')
        nnoremap <silent><buffer><expr> m defx#do_action('move')
        nnoremap <silent><buffer><expr> p defx#do_action('paste')
        nnoremap <silent><buffer><expr> P defx#do_action('preview')
        nnoremap <silent><buffer><expr> K defx#do_action('new_directory')
        nnoremap <silent><buffer><expr> N defx#do_action('new_file')
        nnoremap <silent><buffer><expr> M defx#do_action('new_multiple_files')
        nnoremap <silent><buffer><expr> dd defx#do_action('remove')
        nnoremap <silent><buffer><expr> r defx#do_action('rename')
        nnoremap <silent><buffer><expr> ! defx#do_action('execute_command')
        nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
        nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
        nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
        nnoremap <silent><buffer><expr> ; defx#do_action('repeat')
        nnoremap <silent><buffer><expr> cd defx#do_action('change_vim_cwd')
    endfunction
endfunction
