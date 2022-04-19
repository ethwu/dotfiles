
" Load local `.nvimrc`.
set exrc

au TextYankPost * lua vim.highlight.on_yank { higroup='IncSearch', timeout=150, on_visual=true }

