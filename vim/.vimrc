" notes
" source .vimrc
" :so $MYVIMRC

" list buffers
"   :buffers
" move to buffer
"   :b <x> where x is whatever buffer number

" functions, the '!' means it's safe to reload the function
" so when :so $MYVIMRC is called, vim doesn't complain. 
" apparently some functions are not safe (not idempotent?)
function! Antify()
    set tabstop=2
    set shiftwidth=4
endfunction

function! TwoStop()
    set tabstop=2
    set shiftwidth=2
endfunction

function! DeAmperfy()
    "Get current line...
    let curr_line   = getline('.')
    "Replace raw ampersands...
    let replacement = substitute(curr_line,'&\(\w\+;\)\@!','&amp;','g')
    "Update current line...
    call setline('.', replacement)
endfunction

function! DeLessify()
    let curr_line = getline('.')
    "Replace raw < ...
    let replacement = substitute(curr_line,'<','\&lt\;','g')
    "Update current line...
    call setline('.', replacement)
endfunction

function! DeGreatify()
    let curr_line = getline('.')
    "Replace raw < ...
    let replacement = substitute(curr_line ,'>','\&gt\;' ,'g')
    "Update current line...
    call setline('.', replacement)
endfunction

function! Saintify()
    call DeAmperfy()
    call DeLessify()
    call DeGreatify()
endfunction


" display line numbers
set number
" color syntax hints 
" ? not sure what it users to parse the file
" ? might have perf hit for large files
syntax on
" Lots of different color shcemes :)
" colorscheme oceandeep
" tabs are 4 colums
set tabstop=2
" using reindent operations << or >> insert 4 columns 
set shiftwidth=2
" cause tab key and reindent ops to produce appropriate spaces, instead of a tab control character
set expandtab

" java /ant stuff
autocmd BufRead set makeprg=ant\ -find\ build.xml
" one example of efm
"set efm=\ %#[javac]\ %#%f:%l:%c:%*\\d:%*\\d:\ %t%[%^:]%#:%m,\%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#
" what i'm actually using: 
autocmd BufRead *.java set efm=\ %#[javac]\ %#%f:%l:%c:%*\\d:%*\\d:\ %t%[%^:]%#:%m,\%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#

"plsql, though not sure this is actually working
au BufNewFile,BufRead *.pls,*.plsql,*.sql   setf plsql

"pathogen configuration
silent! execute pathogen#infect()  "silent! keeps vim from complaining 
silent! filetype plugin indent on

"nerdtree

"" NOT_ENABLED 
"" "autostart vim .. annoying, esp. with mysql \e
"" "autocmd vimenter * NERDTree
"" end NOT_ENABLED 

silent! nmap <silent> <special> <F2> :NERDTreeToggle<RETURN>
" see the damn dotiles
silent! let NERDTreeShowHidden=1

"notes
"digraphs in insert mode, ^K + characters for digraph, eg CO₂, superscript,
"subscript, mathematical symbols 

"gq to rewrap text
"

"splits 
"useful if you wanna close the screen, but not unload the buffer
"^w q in active split to close it 
"

" spelling
" 'setlocal' affects only the current buffer, as opposed the global 'set'
" setlocal spell

" map W to w. yay, no more hassles when caps locked
:command W w

" tags
" framework is php
set tags=~/.vim/mytags/framework
