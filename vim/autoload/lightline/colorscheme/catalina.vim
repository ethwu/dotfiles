" =============================================================================
" Filename: autoload/lightline/colorscheme/catalina.vim
" Author: ewu
" License: MIT License
" =============================================================================

let s:fg = [ 7, 15 ]    " white
let s:bg = [ 0, 8 ]     " black
let s:bgrev = [ 8, 0 ]  " black (bright before normal)

if lightline#colorscheme#background() ==# 'light'
    let s:fg = [ 0, 8 ]
    let s:bg = [ 7, 15 ]
    let s:bgrev = [ 15, 7 ]
endif

let s:normal = [ [ s:bg[0], 4, 'italic' ], [ s:bg[0], 4 ] ]
let s:insert = [ [ s:bg[0], 2, 'italic' ], [ s:bg[0], 2 ] ]
let s:replace = [ [ s:bg[0], 6, 'italic' ], [ s:bg[0], 6 ] ]
let s:visual = [ [ s:bg[0], 5, 'italic' ], [ s:bg[0], 5 ] ]

let s:middle = [ s:fg[0], s:bg[0] ]
let s:connector = [ s:fg[0], s:bg[1] ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ s:normal[0], s:connector ]
let s:p.normal.middle = [ s:middle ]
let s:p.normal.right = [ s:normal[1], s:connector, s:middle ]
let s:p.normal.warning = [ [ s:bg[0], 3, 'italic' ] ]
let s:p.normal.error = [ [ 15, 9, 'italic' ] ]

let s:p.insert.left = [ s:insert[0], s:connector ]
let s:p.insert.middle = [ s:middle ]
let s:p.insert.right = [ s:insert[1], s:connector, s:middle ]

let s:p.replace.left = [ s:replace[0], s:connector, s:middle ]
let s:p.replace.middle = [ s:middle ]
let s:p.replace.right = [ s:replace[1], s:connector, s:middle ]

let s:p.visual.left = [ s:visual[0], s:connector, s:middle ]
let s:p.visual.middle = [ s:middle ]
let s:p.visual.right = [ s:visual[1], s:connector, s:middle ]

let s:p.inactive.right = [ s:bg, s:bgrev, s:bgrev ]
let s:p.inactive.middle = [ s:middle ]
let s:p.inactive.left = s:p.inactive.right[1:]

let s:p.tabline.left = [ s:connector ]
let s:p.tabline.middle = [ s:middle ]
let s:p.tabline.right = [ s:connector ]
let s:p.tabline.tabsel = [ [ 7, 13 ] ]

let g:lightline#colorscheme#catalina#palette = lightline#colorscheme#fill(s:p)

