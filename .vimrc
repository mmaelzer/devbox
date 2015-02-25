execute pathogen#infect()
syntax enable
set term=xterm-256color
colorscheme monokai
filetype plugin indent on
set enc=utf-8

highlight clear SignColumn          " Fix vim-gitgutter background
let g:ctrlp_show_hidden = 1         " Let ctrlp see hidden files
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules|.git|env|htmlcov)$',
  \ 'file': '\v\.(pyc)$',
  \ }

let mapleader = ','

au BufNewFile,BufRead *.ejs set filetype=html " Use html syntax highlighting for .ejs files

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd Filetype html setlocal ts=2 sts=2 sw=2
"autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype rst setlocal ts=2 sts=2 sw=2

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


vmap <Tab> >gv
vmap <S-Tab> <gv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'))
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

map <leader>fp :call CtrlpProject()<cr>
map <leader>fm :call CtrlpProject('models')<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GET THE DJANGO PROJECT NAME
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ProjectName()
  let name = system("grep 'name=' setup.py | head -n1 | cut -d '=' -f 2")
  let name = substitute(name, "'", '', 'g')
  let name = substitute(name, ',', '', 'g')
  let name = substitute(name, '\n', '', 'g')
  return name
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GET THE DJANGO PROJECT NAME
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CtrlpProject(...)
  if a:0
    let prefix = a:1
  else
    let prefix = ""
  endif
  exec ":CtrlP " . ProjectName() . "/" . prefix
endfunction
