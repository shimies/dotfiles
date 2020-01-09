function! shimies#init#clang_complete#hook_source() abort
    let g:clang_auto_select = 0
    let g:clang_complete_auto = 1
    let g:clang_user_options = '-std=c++11 -fms-extensions -fgnu-runtime'
    let g:clang_use_library = 1
    let g:clang_default_keymappings = 0


    if has('mac')
        let s:dirlist = [ fnamemodify(system('mdfind -name libclang.dylib'), ':p:h') ]
    else
        let s:dirlist = [ '/opt/clang', '/usr/lib/llvm-3.8/lib', '/usr/lib/llvm-6.0/lib' ]
    endif
    for s:path in s:dirlist
        if isdirectory(s:path)
            for s:file in split(globpath(s:path, 'libclang*.*'), '\n')
                let g:clang_library_path = s:file
                break
            endfor
        endif
    endfor
endfunction
