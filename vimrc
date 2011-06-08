set encoding=utf-8
filetype on
filetype plugin indent on
syntax on

set nocompatible
set t_Co=256

set backspace=indent,eol,start
set history=1000
set showcmd
set showmode
set nowrap
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,*.zip,*.gz,*.bz,*.tar,*.jpg,*.png,*.gif,*.avi,*.wmv,*.ogg,*.mp3,*.mov
set clipboard+=unnamed
set ruler

set incsearch
set hlsearch
set ignorecase
set smartcase
set showmatch

set number
"set autowrite
"set autochdir
set keymodel=startsel,stopsel
set timeoutlen=250
set ttyfast
set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
set novisualbell
set noerrorbells
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set foldmethod=manual

"hide buffers when not displayed
set hidden
set backup                     " Enable creation of backup file.
set backupdir=~/.vim/backup    " Where backups will go.
set directory=~/.vim/tmp       " Where temporary files will go.

"indent settings
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

"mouse settings
set mouse=a

set fo=1
set laststatus=2
set statusline=[%n]\ %<%f%m%r
set statusline+=%w\ %y\ <%{&fileformat}>%\=[%o]\ %l,%c%V\/%L\ \ %P

" Command-T configuration
let g:CommandTMaxHeight=20
"let g:CommandTMatchWindowAtTop=1


"
" key binds
"

" mapping for navigation
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g^
nmap <Down> gj
nmap <Up> gk

" enter fix
map <S-Enter> O<ESC>
map <Enter> o<ESC>

" copy paste
vnoremap <C-C> "+y
inoremap <C-V> <ESC>"+gPi

" duplicate current line
nnoremap <C-d> Yp
" paste to current line
"noremap p P

"f# keys
nmap <silent> <F2> :set invpaste<CR>:set paste?<CR>
nmap <silent> <F3> :set invlist<CR>:set list?<CR>
nmap <silent> <F4> :set invwrap<CR>:set wrap?<CR>
nmap <silent> <F5> :set invhls<CR>:set hls?<CR>

" select all text - doesn't work with tmux
map <C-a> ggVG
" fix file indent
map <C-Z> gg=G

" tabs
nnoremap  tt :tabnew<cr>

" splits
noremap ,v :vsp^<cr>
noremap ,h :split^<cr>

" CTags
map <Leader>rt :!ctags --extra=+f -R --exclude=.svn --exclude=.git --exclude=log *<CR><CR>

" ConqueTerm wrapper
function StartTerm()
  execute 'ConqueTerm ' . $SHELL . ' --login'
  setlocal listchars=tab:\ \
endfunction

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif
endif

" Command-e for ConqueTerm
map <Leader>x :call StartTerm()<CR>

" change to tab #
map 1 :tabn 1<CR>
map 2 :tabn 2<CR>
map 3 :tabn 3<CR>
map 4 :tabn 4<CR>
map 5 :tabn 5<CR>
map 6 :tabn 6<CR>
map 7 :tabn 7<CR>
map 8 :tabn 8<CR>
map 9 :tabn 9<CR>

" Stop using <Insert>
nnoremap a <Insert>

" double 'a' as escape
imap <silent> aa <ESC>

" moving lines
nnoremap <C-DOWN> :m+<CR>==
nnoremap <C-UP> :m-2<CR>==
inoremap <C-DOWN> <Esc>:m+<CR>==gi
inoremap <C-UP> <Esc>:m-2<CR>==gi
vnoremap <C-DOWN> :m'>+<CR>gv=gv
vnoremap <C-UP> :m-2<CR>gv=gv


function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Mm <CR>
endfunction


" make uses real tabs
au FileType make set noexpandtab

" Capfile, Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()

" Make json highlight as javascript
au BufNewFile,BufRead *.json set ft=javascript

" Rdoc syntax
au BufNewFile,BufRead *.rdoc set ft=rdoc

" Make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python  set tabstop=4 textwidth=79



" Trailing whitespace remove on save
autocmd BufWritePre *.rb,*.py,*.c,*.h,*.feature,*.conf,*rc,README,CHANGELOG,README.* :%s/\s\+$//e

function MyTagContext()
  if filereadable(expand('%:p:h') . '/tags')
    return "\<c-x>\<c-]>"
  endif
  " no return will result in the evaluation of the next
  " configured context
endfunction
