
" configure rust.vim
let g:rustfmt_autosave=1

" configure lightline
let g:lightline = {}
let g:lightline.colorscheme = 'catalina'
let g:lightline.mode_map = {
            \ 'n': 'normal',
            \ 'i': 'insert',
            \ 'R': 'replace',
            \ 'v': 'visual',
            \ 'V': 'v-line',
            \ "\<C-v>": 'v-block',
            \ 'c': 'command',
            \ 's': 'select',
            \ 'S': 's-line',
            \ "\<C-s>": 's-block',
            \ 't': 'terminal' }
let g:lightline.active = {}
let g:lightline.active.left =
            \ [ [ 'mode', 'paste' ],
            \   [ 'readonly' ],
            \   [ 'filename', 'modified' ] ]
let g:lightline.active.right =
            \ [ [ 'lineinfo' ],
            \   [ 'percent' ],
            \   [ 'fileformat', 'fileencoding', 'filetype' ] ]
let g:lightline.component = {}
let g:lightline.component.lineinfo = ' %3l:%-2v'
let g:lightline.component_function = { 'readonly': 'PowerReadonly' }
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }

function! PowerReadonly()
    return &readonly ? '' : ''
endfunction

" hide `-- INSERT --`
set noshowmode

