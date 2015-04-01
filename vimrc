" Sets the language of the menu on gvim (dmajkic)
set langmenu=en_US.UTF-8
let $LANG='en'
set encoding=utf-8
scriptencoding utf-8

" Use Vim settings, rather then Vi settings. set early
set nocompatible

" Leader ,
let mapleader = ","

" Core
autocmd GUIEnter * set vb t_vb= " visualbell off (GUI)
autocmd VimEnter * set vb t_vb= " visualbell off (console)
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set nowrap        " No wraping

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set textwidth=80
"set colorcolumn=+1    " Make it obvious where 80 characters is
set number
set numberwidth=5
set splitbelow        " New split to right and bottom
set splitright
set diffopt+=vertical " Always use vertical diffs
set spelllang=en_us
set spellsuggest=best,5
set spellfile=$HOME/.vim-spell-en.utf-8.add
set nolist            " Hide whitespace
set listchars=tab:»·,trail:·,eol:¬,extends:>,precedes:<

nnoremap <Leader>l :set list!<CR>             " Toggle invisible chars
nnoremap <Leader><Space> :StripWhitespace<CR> " Strip trailing whitespace

"set showbreak=↪
set fillchars=vert:│,fold:\⋅

" Undo Options {{{2
set undofile                  " Use undofile to persist undo history
set undolevels=1000           " Increase undo level to 1000
set undodir=~/.vim/undo       " Specifies where to keep undo files
if !isdirectory(expand('~/.vim/undo'))
  silent !mkdir -p ~/.vim/undo
endif

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" | endif

  " Cucumber navigation commands
  autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
  autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-

  " Makefile
  autocmd FileType make set noexpandtab

  " PRG podesavanja
  autocmd BufRead,BufNewFile,BufEnter *.prg,*.ch setlocal tabstop=3
  autocmd BufRead,BufNewFile,BufEnter *.prg,*.ch setlocal shiftwidth=3
  autocmd BufRead,BufNewFile,BufEnter *.prg,*.ch setlocal noexpandtab
augroup END


" Color scheme
colorscheme railscasts

if has("gui_running")

  "highlight Comment guifg=#667b8f
  highlight LineNr guibg=#333333

  if has("gui_gtk2")
    set guifont=Ubuntu\ Mono\ for\ Powerline\ 15
  elseif has("gui_macvim")
    set guifont=Source\ Code\ Pro\ for\ Powerline:h16
  elseif has("gui_win32")
   " set guifont=Lucida_Sans_Typewriter:h14
    set guifont=Sauce_Code_Powerline:h14
  endif

  set lines=40 columns=117
  set cursorline
  set guioptions-=T  " No toolbar
  set guioptions+=c  " Use console dialogs
endif

" Tab completion: tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
  endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

" Fancy symbols in vim powerline on gui
if has("gui_running") || (&t_Co > 100)
  let g:airline_powerline_fonts = 1
endif

" fixes common typos; Mapira č, ; i Č u : za komande
nnoremap ; :
nnoremap č :
nnoremap Č :
command! Wq wq
command! Q q
map <F1> <Esc>
imap <F1> <Esc>

" "make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

" Spisak funkcija na F10
silent! nmap <silent> <F10> :TagbarToggle<CR>
vmap <F10> <esc>:TagbarToggle<cr>
imap <F10> <esc>:TagbarToggle<cr>

" NERDTree cd to root
let NERDTreeChDirMode=2
let NERDTreeIgnore = ['\.pyc$', '\.ntx$', '\.dbf$', '\.dbt$', '\.DBF$', '\.NTX$', '\.DBT$', '\.NTX$', '\.ntx$']
nmap <leader>n :NERDTreeToggle<CR>

" Custom ignores for CtrlP
let g:ctrlp_custom_ignore = '\v.DS_Store|.sass-cache|.bundle|dcu|log|tmp|.git|private|.hg|.svn|node_modules|vendor|bower_components$'
" Command-F for Ack
map <C-f> :Ack<space>

"Rails on main menu"
let g:rails_menu=1

"Ctrl-S key mapping for saving file
"nmap <C-s> :w<CR>
noremap  <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

"mark syntax errors with :signs
let g:syntastic_enable_signs=1

" same indent behaviour in visual mode
vmap > >gv
vmap < <gv

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Fix PgUp i PgDown
map <silent> <PageUp> 1000<C-U>
map <silent> <PageDown> 1000<C-D>
imap <silent> <PageUp> <C-O>1000<C-U>
imap <silent> <PageDown> <C-O>1000<C-D>

" Go support
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabLongestHighlight = 0

nmap <F5> :make<CR>:copen<CR>
nmap <C-B> :make<CR>:copen<CR>

" Cool things from Janus
cmap w!! %!sudo tee > /dev/null % " use :w!! to write using sudo
nmap <leader>fef ggVG=            " format the entire file
nmap <silent><leader>. :bnext<CR>       " Next buffer
nmap <silent><leader>m :bprev<CR>       " Previous buffer
nmap <leader>U mQviwU`Q           " upper/lower word
nmap <leader>L mQviwu`Q

nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`' " Swap two words
nmap <silent> <leader>ul :t.\|s/./=/g\|:nohls<cr>              " Underline the current line with '='
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>         " find merge conflict markers
cmap <C-P> <C-R>=expand("%:p:h") . "/"                         " current dir into a command-line path

