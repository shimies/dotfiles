function! shimies#init#vim_latex#hook_source() abort
    let s:use_xelatex = 0

    " set grepprg=grep\ -nH\ $*
    let g:Imap_UsePlaceHolders = 1
    let g:Imap_DeleteEmptyPlaceHolders = 1
    let g:Imap_StickyPlaceHolders = 0
    let g:Tex_DefaultTargetFormat = 'pdf'
    if s:use_xelatex
        let g:Tex_FormatDependency_pdf = 'pdf'
        let g:Tex_CompileRule_pdf = 'xelatex $*'
    else
        let g:Tex_FormatDependency_pdf = 'dvi,pdf'
        let g:Tex_CompileRule_pdf = 'xdvipdfmx $*.dvi'
        let g:Tex_CompileRule_dvi = 'eptex -fmt=platex -synctex=1 -interaction=nonstopmode -file-line-error $*'
    endif
    let g:Tex_FormatDependency_ps = 'dvi,ps'
    let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
    let g:Tex_BibtexFlavor = 'pbibtex'
    let g:Tex_MakeIndexFlavor = 'mendex $*.idx'
    " let g:Tex_MakeIndexFlavor = 'makeindex $*.idx'
    let g:Tex_UseEditorSettingInDVIViewer = 1

    " Executable paths for viewer
    if has('win64') || has('win32unix') || has('win32')
        let g:Tex_ViewRule_dvi = 'rundll32 shell32.dll,ShellExec_RunDLL sumatrapdf'
        let g:Tex_ViewRule_pdf = 'rundll32 shell32.dll,ShellExec_RunDLL sumatrapdf'
    else
        let g:Tex_ViewRule_dvi = 'xreader >/dev/null 2>&1'
        let g:Tex_ViewRule_pdf = 'xreader >/dev/null 2>&1'
    endif
endfunction

function! shimies#init#vim_latex#hook_post_source() abort
    " Customize folding for beamer frame
    let g:Tex_FoldedEnvironments .= ',wrapfigure,frame,block,exampleblock,alertblock'

    " Prevent stopping compiling by warnings
    let g:Tex_IgnoredWarnings .=
        \ "\n".
        \ "LaTeX Font Warning:\n".
        \ "LaTeX Warning: Command %s has changed.\n".
        \ "Package typearea Warning:\n".
        \ "Package caption Warning:\n".
        \ "Package wrapfig Warning:"
    let g:Tex_IgnoreLevel = 12
endfunction
