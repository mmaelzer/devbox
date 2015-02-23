execute pathogen#infect()
syntax enable
set term=xterm-256color
colorscheme monokai
filetype plugin indent on
set enc=utf-8

highlight clear SignColumn          " Fix vim-gitgutter background
let g:ctrlp_show_hidden = 1         " Let ctrlp see hidden files
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules|env|htmlcov)$',
  \ 'file': '\v\.(pyc)$',
  \ }

let mapleader = ','

au BufNewFile,BufRead *.ejs set filetype=html " Use html syntax highlighting for .ejs files

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2

set autoindent
set cursorline                      " Highlight the current line
set ruler                           " Show cursor position
set number                          " Show line numbers
set title                           " Set terminal's title
set listchars=tab:▸\ ,eol:¬         " Set list chars if :set list is used
set nobackup                        " Don't make a backup before overwriting a file.
set nowritebackup                   " And again.
set noswapfile                      " no swap files
set incsearch                       " Highlight matches as you type.
set hlsearch                        " Highlight matches.

map <C-n> :NERDTreeToggle<CR>
