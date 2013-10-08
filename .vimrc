" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup files
  set backupdir=~/.tmp,~/
  set directory=~/.tmp,~/
endif

set autoread    "No message when the current file was changed outside of Vim

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ignorecase
set smartcase
set number
set relativenumber
set hidden " allow buffers to be hidden without write
set scrolloff=4		" keep at least 4 lines of context
syntax enable
syntax on
filetype on
filetype indent on
filetype plugin on

" Change cursor shape in different modesFor iTerm2 on OS X
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" current directory is always matching the
" content of the active window
set autochdir

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" will buffer screen updates instead of updating all the time
set lazyredraw
set ttyfast

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
 if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" pathogen
execute pathogen#infect()

set runtimepath^=~/.vim/bundle/ctrlp.vim

" Setting up Vundle - the vim plugin bundler
filetype off                   " required!

 set rtp+=~/.vim/bundle/vundle/
 call vundle#rc()

 " let Vundle manage Vundle
 " required! 
    Bundle 'gmarik/vundle'
    "Add your bundles here
    Bundle 'a.vim'
    Bundle 'kien/ctrlp.vim'
    Bundle 'scrooloose/syntastic'
    Bundle 'altercation/vim-colors-solarized'
    Bundle 'amiorin/ctrlp-z'
    " Bundle 'https://github.com/tpope/vim-fugitive' "So awesome, it should be illegal
    " Bundle 'https://github.com/tpope/vim-fugitive' "for git https://github.com/tpope/vim-fugitive
    Bundle 'YouCompleteMe'
    "...All your other bundles...

filetype plugin indent on     " required!
 "
 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..
" Setting up Vundle - the vim plugin bundler end

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"if &t_Co > 2 || has("gui_running")
set hlsearch
syntax on
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
"endif

let g:ycm_collect_identifiers_from_tags_files = 1
" powerline
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" set 'updatetime' to 4 seconds when in insert mode
au InsertEnter * let updaterestore=&updatetime | set updatetime=4000
au InsertLeave * let &updatetime=updaterestore

" automatically leave insert mode after 'updatetime' milliseconds of inaction
au CursorHoldI * stopinsert

set clipboard=unnamed " use system clipboard

" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" Leave insert mode when vim loses focus
autocmd FocusLost * nested silent! wa
autocmd FocusLost * if mode()[0] =~ 'i\|R' | call feedkeys("\<Esc>") | endif

augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au VimEnter * setlocal cursorcolumn
    au WinEnter * setlocal cursorline
    au WinEnter * setlocal cursorcolumn
    au BufWinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorcolumn
    au WinLeave * setlocal nocursorline
    au WinLeave * setlocal nocursorcolumn
augroup END

"
" LEADER KEY!!!
"
" set leader key to spacebar
let mapleader = "\<space>"

" Insert new line below and return to line
nmap <LEADER><CR> mzo<Esc>`z
" Insert new line above and return to line
nmap <LEADER><S-CR> mzO<Esc>`z

" Setup command for unnamed register
nmap <LEADER>- "_
vmap <LEADER>- "_

" Add semi colon to the end of current line
nmap <LEADER>; mzA;<ESC>`z

" clear search highlighting
nmap <silent> <LEADER>/ :nohlsearch<CR>

" toggle viewing whitespace
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>. :set nolist!<CR>
nmap <leader>lw :CtrlP<CR><C-\>w
" take previously deleted text, create line above current line, paste text,
" user sets variable
" nmap <LEADER>a mz<ESC>O<ESC>p$a;<ESC>^mxi = <ESC>`x
" Script moves to begining of word then yanks variable name then
" pastes it at previous yark
" nmap <LEADER>aa <ESC>bye`zP
nmap <LEADER>a <ESC>:A<CR>

" git conflict seperator search
nmap <leader>c /<<<<<<<\\|=======\\|>>>>>>><CR>
" NSLog object
nmap <leader>lo iNSLog(@"%@", );<ESC>F)
" Edit .vimrc
nmap <leader>ve :e $MYVIMRC<CR>
" Reload .vimrc
nmap <leader>vs :so $MYVIMRC<CR>:nohlsearch<CR>:echo ".vrimrc sourced"<CR>
" Install Vundle Bundles
nmap <leader>vv :BundleInstall<CR>
nmap <leader>y :%s/'-/-/<CR>:%s/',//<CR>
" Run marco stored in q register
nmap <LEADER>q @q
" Split line before cursor
nmap <LEADER>s hmzli<Enter><Esc>`z
" Split line before cursor
nmap <LEADER>S i<Enter><Esc>ddkP
" Move beginning brace to next line
nmap <LEADER>{ mz0f{r<Enter>i{<Esc>`z
" Move end brace to next line
nmap <LEADER>} mz0f}r<Enter>i}<Esc>`z
" Append '.0f' to flaot
nmap <LEADER>f ea.0f<Esc>

" The best way to get filetype-specific indentation is to use filetype plugin indent on in your vimrc. Then you can specify things like set sw=4 sts=4 et in .vim/ftplugin/c.vim, for example, without having to make those global for all files being edited and other non-C type syntaxes will get indented correctly, too (even lisps).
 "You can replace all the tabs with whitespace in the entire file with :%retab
set cindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
set wildignore+=*.o,*.obj,*.a,*.lib,*.elf,*.dll,*.exe " ignore binaries
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
" set showmatch                  " show matching brackets

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" Remove trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" Show trailing whitespace only after some text (ignores empty lines):
" /\(\S\+\)\@<=\s\+$
" try control e and y in insert mode, writes char by char above or below line
" Vim lets you define an indentexpr which defines the behaviour of the = operator 
