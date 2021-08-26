
" configure rust.vim
let g:rustfmt_autosave=1

" configure lightline

let g:lightline = {
    \   'colorscheme': '16color',
    \   'active': {
    \       'left': [ [ 'mode', 'paste' ],
    \                 [ 'readonly' ],
    \                 [ 'filename', 'modified' ] ],
    \       'right': [ [ 'lineinfo' ],
    \                  [ 'percent' ],
    \                  [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \   }, 'component': {
    \       'lineinfo': ' %3l:%-2v'
    \   }, 'component_function': {
    \       'readonly': 'PowerReadonly'
    \   } }

let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }

function! PowerReadonly()
    return &readonly ? '' : ''
endfunction

" hide `-- INSERT --`
set noshowmode

