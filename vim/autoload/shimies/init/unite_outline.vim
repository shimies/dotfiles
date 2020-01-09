function! shimies#init#unite_outline#hook_source() abort
    let g:unite_source_outline_filetype_options = {
        \ '*': {
        \     'auto_update': 1,
        \     'auto_update_event': 'write',
        \ },
        \ 'javascript': {
        \     'ignore_types': [ 'comment' ],
        \ },
        \ 'markdown': {
        \     'auto_update_event': 'hold',
        \ },
        \ }

    nnoremap <silent> [unite]o :<C-u>Unite -buffer-name=outline -default-action=persist_open -direction=botright -vertical -winwidth=30 outline<CR>
endfunction
