if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    autocmd!
    autocmd! BufRead,BufNewFile *.md setfiletype markdown
    autocmd! BufRead,BufNewFile .tmux.conf*,tmux.conf* setfiletype tmux
augroup END
