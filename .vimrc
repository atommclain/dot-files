" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
  set backupdir=~/.tmp,~/
  set directory=~/.tmp,~/
endif

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ignorecase
set smartcase
set number
set hidden " allow buffers to be hidden without write
set scrolloff=4		" keep at least 4 lines of context
syntax enable
syntax on
filetype on
filetype indent on
filetype plugin on

" current directory is always matching the
" content of the active window
set autochdir

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

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

filetype off                   " required!

" Setting up Vundle - the vim plugin bundler
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    Bundle 'gmarik/vundle'
    "Add your bundles here
    Bundle 'Syntastic'
    Bundle 'altercation/vim-colors-solarized'
    " Bundle 'https://github.com/tpope/vim-fugitive' "So awesome, it should be illegal
" Bundle 'https://github.com/tpope/vim-fugitive' "for git https://github.com/tpope/vim-fugitive
 Bundle 'YouCompleteMe'
    "...All your other bundles...
    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :BundleInstall
    endif
" Setting up Vundle - the vim plugin bundler end

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"if &t_Co > 2 || has("gui_running")
  set hlsearch
  syntax on
  set background=dark
  colorscheme solarized
"endif
let g:ycm_collect_identifiers_from_tags_files = 1
" powerline
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
let g:Powerline_symbols = 'fancy'

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

autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" Leave insert mode when vim loses focus
autocmd FocusLost * nested silent! wa
autocmd FocusLost * if mode()[0] =~ 'i\|R' | call feedkeys("\<Esc>") | endif

"
" LEADER KEY!!!
"
" set leader key to spacebar
let mapleader = "\<space>"

nmap <LEADER><CR> mzo<Esc>`z		 " Insert new line below and return to line
nmap <LEADER><S-Enter> mzO<Esc>`z		 " Insert new line above and return to line

" Setup command for unnamed register
nmap <LEADER>- "_
vmap <LEADER>- "_

nmap <LEADER>; mzA;<ESC>`z		 " Add semi colon to the end of current line

" clear search highlighting
nmap <silent> <LEADER>/ :nohlsearch<CR>

" toggle viewing whitespace
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>. :set nolist!<CR>

" take previously deleted text, create line above current line, paste text,
" user sets variable
nmap <LEADER>a mz<ESC>O<ESC>p$a;<ESC>^mxi = <ESC>`x
" Script moves to begining of word then yanks variable name then
" pastes it at previous yark
nmap <LEADER>aa <ESC>bye`zP

nnoremap <leader>c /<<<<<<<\\|=======\\|>>>>>>><CR> " git conflict seperator search
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>  " toggle VIM hardmode
nmap <leader>lo iNSLog(@"%@", );<ESC>F)	 " NSLog object
nmap <leader>ve :tabedit $MYVIMRC<CR>	 " Edit .vimrc
nmap <leader>vr :so $MYVIMRC<CR>	 " Reload .vimrc
nmap <LEADER>q @q			 " Run marco stored in q register
nmap <LEADER>s hmzli<Enter><Esc>`z 	 " Split line before cursor
nmap <LEADER>{ mz0f{r<Enter>i{<Esc>`z		" Move beginning brace to next line

" The best way to get filetype-specific indentation is to use filetype plugin indent on in your vimrc. Then you can specify things like set sw=4 sts=4 et in .vim/ftplugin/c.vim, for example, without having to make those global for all files being edited and other non-C type syntaxes will get indented correctly, too (even lisps).
" You can replace all the tabs with whitespace in the entire file with :%retab
" set cindent
" set tabstop=4
" set shiftwidth=4
" set expandtab

" Remove trailing whitespace
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" Show trailing whitespace only after some text (ignores empty lines):
" /\(\S\+\)\@<=\s\+$
" try control e and y in insert mode, writes char by char above or below line
