silent! py3 pass
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
set autowrite     " Automatically :write before running commands
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set ignorecase    " ... ingnoring case
set smartcase     " ... except when Uppercase typed
set hlsearch      " ... and highlight found words
set laststatus=2  " Always display the status line
set nowrap        " No wraping
" set clipboard=unnamedplus " Use system clipboard

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Vundle plugins
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
set number             " Show line numbers
set numberwidth=5      " ...width 5 chars
set splitbelow         " New split to bottom
set splitright         " ... and to right
set diffopt+=vertical  " Always use vertical diffs
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

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-

  " Makefile
  autocmd FileType make set noexpandtab

augroup END


" Color scheme
colorscheme railscasts
highlight LineNr guibg=#111111 ctermfg=DarkGrey
highlight CursorLineNr guibg=#111111 guifg=Grey ctermfg=DarkGrey
set nocursorline

if has("gui_running")

  if has("gui_gtk2")
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 14
  elseif has("gui_macvim")
    set guifont=Monaco:h16
  elseif has("gui_win32")
   " set guifont=Lucida_Sans_Typewriter:h14
    set guifont=Sauce_Code_Powerline:h13
  endif

  set lines=40 columns=117
  set guioptions-=T  " No toolbar
  set guioptions+=c  " Use console dialogs
  set guioptions-=L  " Disable scroll bar
  set guioptions-=r  " Disable scroll bar
else
  if $TMUX != ""
    set t_ut=
  endif
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

" fixes common typos; Mapira č, ; i Č u : za komande
nnoremap - /
nmap š [
nmap đ ]
omap š [
omap đ ]
xmap š [
xmap š ]
nmap Š {
nmap Đ }
nmap <F21> -
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
" let NERDTreeChDirMode=2
" let NERDTreeIgnore = ['\.pyc$', '\.ntx$', '\.dbf$', '\.dbt$', '\.DBF$', '\.NTX$', '\.DBT$', '\.NTX$', '\.ntx$']
" nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>n :Lex<CR>

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
"let g:syntastic_enable_signs=1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_ruby_checkers = ['mri']
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

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

" Leader p and Leader y for system copy-paste
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" v-v-v expand selection
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Build commnad to feed muscle memory
nmap <F5> :Make<CR>:copen<CR>
nmap <C-B> :Make<CR>:copen<CR>

" Cool things from Janus
cmap w!! %!sudo tee > /dev/null % " use :w!! to write using sudo
nmap <leader>fef ggVG=            " format the entire file
nmap <silent><leader>. :bnext<CR> " Next buffer
nmap <silent><leader>m :bprev<CR> " Previous buffer
nmap <leader>U mQviwU`Q           " UPPER word
nmap <leader>L mQviwu`Q           " lower word

nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`' " Swap two words
nmap <silent> <leader>ul :t.\|s/./=/g\|:nohls<cr>              " Underline the current line with '='
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>         " find merge conflict markers
cmap <C-P> <C-R>=expand("%:p:h") . "/"                         " current dir into a command-line path

if executable('ag')
  nnoremap K :Ack! "\b<C-R><C-W>\b"<CR>
  "let g:ackprg = 'ag --vimgrep'
  let g:ackprg="ag --nogroup --nocolor --column"
  set grepformat=%f:%l%c%m
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --column
endif

if executable('rg')
  nnoremap K :Ack! "\b<C-R><C-W>\b"<CR>
  nnoremap <Leader>g :silent lgrep<Space>
  let g:ackprg="rg --vimgrep --no-heading --smart-case"
  set grepformat=%f:%l%c%m
  " Use ag over grep
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif

" Javascripting
let g:jsx_ext_required = 0
"let g:syntastic_javascript_checkers = ['eslint']

" ALE
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title
let g:ale_linters = {
  \  'ruby': ['solargraph'],
  \  'python': ['flake8', 'pylint'],
  \  'javascript': ['prettier', 'eslint'],
  \}

" Lightline
let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ },
\ }

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('😞 %dW ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('😞 %d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✨ all good ✨' : ''
endfunction

map <C-p> :GFiles<CR>

" Snipet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)


" FZF
" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
autocmd! FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler

