if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    au BufNewFile,BufRead justfile set filetype=just | packadd just-vim

    au BufNewFile,BufRead *.rkt set filetype=racket | packadd vim-racket
    au BufNewFile,BufRead *.{pm,pp,ptree} set filetype=pollen | packadd vim-racket | packadd vim-pollen
    au BufNewFile,BufRead *.html.p set filetype=html
    au BufNewFile,BufRead *.{pdf,txt}.p set filetype=pollen | packadd vim-racket | packadd vim-pollen

    au BufNewFile,BufRead *.{hb,hbs,hdbs,handlebars} set filetype=handlebars | packadd vim-mustache-handlebars
augroup END

