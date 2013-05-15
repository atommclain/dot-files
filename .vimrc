" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

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

" powerline
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
let g:Powerline_symbols = 'fancy'

set backupdir=~/.tmp
set number

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

" use system clipboard
set clipboard=unnamed

" highlight searches
set hlsearch

"
" LEADER KEY!!!
"
" set leader key to spacebar
let mapleader = "\<space>"

" Insert new line below and return to line
nmap <LEADER><CR> o<Esc>k

" Insert new line above and return to line
nmap <LEADER><S-Enter> O<Esc>j

" Setup command for unnamed register
nmap <LEADER>- "_
vmap <LEADER>- "_

" Add semi colon to the end of current line
nmap <LEADER>; mzA;<ESC>`z

" :so $MYVIMRC

autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" git conflict seperator search
nnoremap <leader>c /<<<<<<<\\|=======\\|>>>>>>><CR>

" toggle VIM hardmode
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

" Edit .vimrc
nmap <leader>v :tabedit $MYVIMRC<CR>
nmap <leader>vr :so $MYVIMRC<CR>

" Run marco stored in q register
nmap <LEADER>q @q

" Split line before cursor
nmap <LEADER>s hmzli<Enter><Esc>`z

" take previously deleted text, create line above current line, paste text,
" user sets variable
nmap <LEADER>a mz<ESC>O<ESC>p$a;<ESC>^mxi = <ESC>`x
" Script moves to begining of word then yanks variable name then
" pastes it at previous yark
nmap <LEADER>aa <ESC>bye`zP
