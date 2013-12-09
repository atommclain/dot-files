"================
" Junk
"================
"{{{
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
set hidden " allow buffers to be hidden without write
set scrolloff=6
syntax enable
syntax on
filetype on
filetype indent on
filetype plugin on
set hlsearch
syntax on
set background=dark
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set clipboard=unnamed " use system clipboard
set wildignore+=*.o,*.obj,*.a,*.lib,*.elf,*.dll,*.exe " ignore binaries
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.png,*.html,*.doc,*.md5
set wildignore+=*.mobileprovision,*.py,*.js,*.png,*.sh,*.entitlements,*.plist,*.pch,*.json,*.rb

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


" set 'updatetime' to 4 seconds when in insert mode
au InsertEnter * let updaterestore=&updatetime | set updatetime=4000
au InsertLeave * let &updatetime=updaterestore

" automatically leave insert mode after 'updatetime' milliseconds of inaction
au CursorHoldI * stopinsert

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
"}}}

"================
" Plugins
"================
"{{{
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
    Bundle 'tpope/vim-fugitive'
    "Bundle 'YouCompleteMe'
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
let g:solarized_termcolors=256
colorscheme solarized
"endif

let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_confirm_extra_conf = 0
" powerline
let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|png|html|js|py|mobileprovision|plist)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
"}}}

"================
" Mappings
"================
"{{{

"================
" disable arrow keys
"================
"{{{
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
"}}}

"================
" LEADER KEY!!!
"================
"{{{
" set leader key to spacebar
let mapleader = "\<space>"

" Insert new line below and return to line
nnoremap <LEADER><CR> mzo<Esc>`z
" Insert new line above and return to line
nnoremap <LEADER><S-CR> mzO<Esc>`z

" Setup command for unnamed register
nnoremap <LEADER>- "_
vnoremap <LEADER>- "_

" Add semi colon to the end of current line
nnoremap <LEADER>; mzA;<ESC>`z

" clear search highlighting
nnoremap <silent> <LEADER>/ :nohlsearch<CR>

" toggle viewing whitespace
set listchars=nbsp:·,tab:⟶\ ,trail:·,eol:¬
nnoremap <silent> <leader>. :set nolist!<CR>
nnoremap <leader>lw :CtrlP<CR><C-\>w
" take previously deleted text, create line above current line, paste text,
" user sets variable
" nnoremap <LEADER>a mz<ESC>O<ESC>p$a;<ESC>^mxi = <ESC>`x
" Script moves to begining of word then yanks variable name then
" pastes it at previous yark
" nnoremap <LEADER>aa <ESC>bye`zP
" A.vim alternative file
nnoremap <LEADER>a <ESC>:A<CR>
" Buffer management: list buffers
nnoremap <LEADER>b :buffers<CR>:buffer<Space>
" Buffer management: delete current buffer
nnoremap <LEADER>d :bd<CR>
" git conflict seperator search
nnoremap <leader>c /<<<<<<<\\|=======\\|>>>>>>><CR>
" edit Foo.m
nnoremap <leader>em :e ~/objctest/Foo.m<CR>
" Edit .vimrc
nnoremap <leader>ev :e $MYVIMRC<CR>
" NSLog object
nnoremap <leader>lo iNSLog(@"%@", );<ESC>F)
" NSLog string
nnoremap <leader>ls iNSLog(@"");<ESC>F"i
"Fugitive
nnoremap <LEADER>gd :Gdiff<CR>
nnoremap <LEADER>go <C-W><C-O>:diffoff<CR>
nnoremap <LEADER>gs :Gstatus<CR>
" Buffer management: next buffer
nnoremap <LEADER>n :bn<CR>
" Reload .vimrc
nnoremap <leader>vs :so $MYVIMRC<CR>:nohlsearch<CR>:echom ".vrimrc sourced"<CR>
" Buffer management: previous buffer
nnoremap <LEADER>p :bp<CR>
" Run marco stored in q register
nnoremap <LEADER>q @q
" Split line before cursor
nnoremap <LEADER>s hmzli<Enter><Esc>`z
" Split line before cursor
nnoremap <LEADER>S i<Enter><Esc>ddkP
" Move beginning brace to next line
nnoremap <LEADER>{ mz0f{r<Enter>i{<Esc>`z
" Move end brace to next line
nnoremap <LEADER>} mz0f}r<Enter>i}<Esc>`z
" Append '.0f' to flaot
nnoremap <LEADER>f ea.0f<Esc>



" Remove trailing whitespace from line
" nnoremap <silent> <F5> :let _s=@/<Bar>:s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" Remove trailing whitespace from line, and convert tabs to spaces
nnoremap <silent> <F5> :let _s=@/<Bar>:s/\s\+$//e<Bar>:s/\t/\ \ \ \ /g<Bar>:let @/=_s<Bar>:nohl<CR>

" Show trailing whitespace only after some text (ignores empty lines):
" /\(\S\+\)\@<=\s\+$
"}}}

"}}}
