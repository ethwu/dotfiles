
" 16-color color scheme
colorscheme catalina

" indent guides
let g:indentguides_ignorelist = [ 'text', 'help' ]
let g:indentguides_spacechar = '┆'
let g:indentguides_tabchar = '│'

" configure coc.vim
set signcolumn=yes

" git gutter
highlight GitGutterAdd          ctermfg=2   cterm=none
highlight GitGutterChange       ctermfg=3   cterm=none
highlight GitGutterDelete       ctermfg=1   cterm=none
highlight GitGutterChangeDelete ctermfg=6   cterm=none

" texlab language server
let g:tex_flavor = 'latex'
" do not conceal characters
let g:tex_conceal = ''

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

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location
" list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-prev)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

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
            \   [ 'readonly', 'modified' ],
            \   [ 'filename', 'gitprojstatus', 'gitstatus' ] ]
let g:lightline.active.right =
            \ [ [ 'lineinfo' ],
            \   [ 'percent' ],
            \   winwidth(0) >= 80 ?
                \ [ 'fileformat', 'fileencoding', 'filetype' ] :
                \ [] ]
let g:lightline.inactive = {}
let g:lightline.inactive.left =
            \ [ [ 'inactive' ],
            \   [ 'readonly', 'modified' ],
            \   [ 'filename' ] ]
let g:lightline.inactive.right =
            \ [ [ 'lineinfo' ] ]
let g:lightline.component = {}
let g:lightline.component.inactive = '%{winwidth(0) > 32 ? "inactive" : ""}'
let g:lightline.component.lineinfo = ' %3l:%-2v'
let g:lightline.component.paste = '%{&paste ? "paste" : ""}'
let g:lightline.component.readonly = '%{&readonly ? "" : ""}'
let g:lightline.component_function = {
            \ 'gitstatus': 'LightlineGitStatus',
            \ 'gitprojstatus': 'LightlineGitProjectStatus' }
" let g:lightline.separator = { 'left': '', 'right': '' }
" let g:lightline.subseparator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '│', 'right': '│' }

" function! LightlineGitBlame()
"     let blame = get(b:, 'coc_git_blame', '')
"     return winwidth(0) > 120 && blame != '' ? blame : ''
" endfunction

function! LightlineGitStatus()
    return winwidth(0) > 120 ? trim(get(b:, 'coc_git_status', '')) : ''
endfunction

function! LightlineGitProjectStatus()
    return winwidth(0) > 120 ? get(g:, 'coc_git_status', '') : ''
endfunction

" User Commands

" Call `just`.
noremap <Leader>j :!just
" Call `make`.
noremap <Leader>m :make

" Suspend the process.
noremap <Leader><Leader> 

