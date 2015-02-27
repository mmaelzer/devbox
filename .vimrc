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
map <leader>f :CtrlP .<cr>
map <leader>F :CtrlP %%<cr>
map <leader>fp :call CtrlpProject()<cr>
map <leader>fm :call CtrlpProject('models')<cr>


let mapleader = ','

au BufNewFile,BufRead *.ejs set filetype=html " Use html syntax highlighting for .ejs files

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
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

map ; :
noremap ;; ;

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunTests(test_name)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    let project_name = ProjectName()
    exec ":!./env/bin/python test_project/manage.py test " . a:test_name . " --settings=" . project_name . ".test_settings"
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), 'test_') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(TranslateTestFile(t:grb_test_file) . command_suffix)
endfunction

function! TranslateTestFile(filename)
    let test_name = substitute(a:filename, '/', '.', 'g')
    let test_name = substitute(test_name, '.py', '', '')
    return test_name
endfunction

function! RunNearestTest()
    let test_line_number = line('.')
    let module_details = system('line_to_path ' . expand("%") . " " . test_line_number)
    let module_details = substitute(module_details, '\n', '', '')
    call RunTestFile(module_details)
endfunction

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
" CTRLP + django project dirs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CtrlpProject(...)
  if a:0
    let prefix = a:1
  else
    let prefix = ""
  endif
  exec ":CtrlP " . ProjectName() . "/" . prefix
endfunction

map <leader>t :call RunTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>
map <leader>a :call RunTests('')<cr>
map <leader>d /def 
map <leader>c /class 

