if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    au BufNewFile,BufRead justfile setf make | set expandtab
augroup END

autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc | setlocal shiftwidth=2 softtabstop=2 expandtab

