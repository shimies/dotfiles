function! shimies#init#clang_complete#hook_source() abort
    let g:clang_auto_select = 0
    let g:clang_complete_auto = 1
    let g:clang_user_options = '-std=c++11 -fms-extensions -fgnu-runtime'
    let g:clang_use_library = 1
    let g:clang_default_keymappings = 0


    if has('mac')
        let s:direxps = [ fnamemodify(system('mdfind -name libclang.dylib'), ':p:h') ]
        let s:lib_suffix = 'dylib'
    else
        let s:direxps = [ '/opt/clang', '/usr/lib', '/usr/lib/llvm*/**/lib' ]
        let s:lib_suffix = 'so'
    endif
    for s:direxp in s:direxps
        for s:dir in glob(s:direxp, v:false, v:true)
            for s:file in globpath(s:dir, printf('libclang.%s', s:lib_suffix), v:false, v:true)
                let g:clang_library_path = s:file
                break
            endfor
        endfor
    endfor
endfunction
