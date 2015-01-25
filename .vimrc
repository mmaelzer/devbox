execute pathogen#infect()
syntax enable
set background=dark
colorscheme solarized
filetype plugin indent on
set enc=utf-8

set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set autoindent
set ruler                           " Show cursor position
set number                          " Show line numbers
set title                           " Set terminal's title
set listchars=tab:▸\ ,eol:¬         " Set list chars if :set list is used

map <C-n> :NERDTreeToggle<CR>
