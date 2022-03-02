
" configure rust.vim
let g:rustfmt_autosave=1

" configure coc.vim
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  " set signcolumn=number
  set signcolumn=yes
else
  set signcolumn=yes
endif

" git gutter
highlight GitGutterAdd ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
let g:lightline.inactive = {}
let g:lightline.inactive.left =
            \ [ [ 'inactive' ],
            \   [ 'readonly' ],
            \   [ 'filename', 'modified' ] ]
let g:lightline.inactive.right =
            \ [ [ 'lineinfo' ] ]
let g:lightline.component = {}
let g:lightline.component.inactive = 'inactive'
let g:lightline.component.lineinfo = ' %3l:%-2v'
let g:lightline.component_function = { 
            \ 'paste': 'LightlinePaste',
            \ 'readonly': 'LightlineReadonly' }
" let g:lightline.separator = { 'left': '', 'right': '' }
" let g:lightline.subseparator = { 'left': '', 'right': '' }

function! LightlinePaste()
    return &paste ? 'paste' : ''
endfunction

function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction

" hide `-- INSERT --`
set noshowmode

