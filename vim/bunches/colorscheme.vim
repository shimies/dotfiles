" Enable color scheme
if has('syntax')
    syntax on
endif
if has('unix') && $TERM != 'linux'
    set t_Co=256
endif
if has('win64') || has('win32')
    colorscheme wombat256mod
elseif has('win32unix')
    colorscheme wombat256mod
elseif $TERM == 'linux'
    colorscheme desert
else
    colorscheme wombat256mod
endif

" Adjust color scheme for my taste
if g:colors_name == 'wombat256mod'
    " set background=dark
    " set background=light
    highlight Comment gui=NONE
    highlight StatusLine gui=NONE
    highlight String gui=NONE
endif
