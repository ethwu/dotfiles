if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    au BufNewFile,BufRead justfile set filetype=just | packadd just-vim
augroup END

