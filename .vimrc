
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup		" keep backup files
set backupdir=~/.tmp,~/
set directory=~/.tmp,~/

set autoread		" reload files when changed outside of Vim
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set number		" show line number
set hidden		" allow buffers to be hidden without write
set scrolloff=6
set linebreak		" wrap lines without inserting newline
set gdefault		" by default substitutions have 'g' flag
set modeline		" turn on modelines

syntax on
filetype on
filetype indent on	" load filetype-specific indent files
filetype plugin on
set background=dark
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set clipboard=unnamed " use system clipboard

set wildignore+=*.o,*.obj,*.a,*.lib,*.elf,*.dll,*.exe " ignore binaries
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.png,*.html,*.doc,*.md5
set wildignore+=*.mobileprovision,*.py,*.js,*.png,*.sh,*.entitlements,*.plist,*.pch,*.json,*.rb

set showmatch		" highlight matching [{()}]
" Visual selection of current line minus indentation blockwise
nnoremap vv ^<C-v>g_

if has("macunix")
  " Change cursor shape in different modesFor iTerm2 on OS X
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

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

" Show diff to a file, use :diffoff to turn off
 if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
\ | wincmd p | diffthis
endif

" Auto Command Groups {{{
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

  " Don't expand tabs when editing vimrc
  autocmd BufReadPost .vimrc setlocal noexpandtab
  " Source the vimrc file after saving it
  autocmd bufwritepost .vimrc source $MYVIMRC

augroup END

" set 'updatetime' to 3 seconds when in insert mode
" au InsertEnter * let updaterestore=&updatetime | set updatetime=3000
" au InsertLeave * let &updatetime=updaterestore

" automatically leave insert mode after 'updatetime' milliseconds of inaction
" au CursorHoldI * stopinsert

augroup LeaveInsert
    au!
    " Leave insert mode when vim loses focus
    autocmd FocusLost * nested silent! wa
    autocmd FocusLost * if mode()[0] =~ 'i\|R' | call feedkeys("\<Esc>") | endif
augroup END

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
" }}}
" Plugins {{{

" Pathogen
 execute pathogen#infect()
 syntax on
 filetype plugin indent on

set runtimepath^=~/.vim/bundle/ctrlp.vim

" Solarize
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"if &t_Co > 2 || has("gui_running")
let g:solarized_termcolors=256
colorscheme solarized
"endif

" You complete me
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_confirm_extra_conf = 0

" Airline
if has("macunix") && $TERM_PROGRAM != "Apple_Terminal"
" if has("gui_macvim")
" if $TERM_PROGRAM == "iTerm.app"
  let g:airline_powerline_fonts = 1
endif
"if !exists('g:airline_powerline_fonts')
"    let g:airline_left_sep='›'
"    let g:airline_right_sep='‹'
"endif
let g:airline#extensions#tabline#enabled = 1

" Vim Hard Mode
"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
"nnoremap <LEADER>h <Esc>:call ToggleHardMode()<CR>

" Contrl-P
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|png|html|js|py|mobileprovision|plist)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

"}}}
" Leader {{{
" set leader key to spacebar
let mapleader = "\<space>"

" Insert space
nnoremap <LEADER><SPACE> i <Esc>l
" Insert new line below and return to line
nnoremap <LEADER><CR> mzo<Esc>`z
" Insert new line above and return to line
nnoremap <LEADER><S-CR> mzO<Esc>`z

" Setup command for unnamed register
nnoremap <LEADER>- "_
vnoremap <LEADER>- "_

" Add semi colon to the end of current line
nnoremap <LEADER>; mzA;<ESC>`z


nnoremap <LEADER>lw :CtrlP<CR><C-\>w
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
" Buffer management: delete current buffer discarding changes
nnoremap <LEADER>D :bd!<CR>
" edit Foo.m
nnoremap <LEADER>em :e ~/objctest/Foo.m<CR>
" Edit .vimrc
nnoremap <LEADER>ev :e $MYVIMRC<CR>
"Fugitive
nnoremap <LEADER>gd :Gdiff<CR>
nnoremap <LEADER>go <C-W><C-O>:diffoff<CR>
nnoremap <LEADER>gs :Gstatus<CR>
" Buffer management: next buffer
nnoremap <LEADER>n :bn<CR>
" Reload .vimrc
nnoremap <LEADER>vs :so $MYVIMRC<CR>:nohlsearch<CR>:echom ".vrimrc sourced"<CR>
" Buffer management: previous buffer
nnoremap <LEADER>p :bp<CR>
" Run marco stored in q register
nnoremap <LEADER>q @q
" execute line as shell command
" yank line without whitespace, paste into ex command line
nnoremap <LEADER>r ^yg_:!<C-r>"
" Split line before cursor
nnoremap <LEADER>s hmzli<Enter><Esc>`z
" Split line before cursor
nnoremap <LEADER>S i<Enter><Esc>ddkP
" Move beginning brace to next line
nnoremap <LEADER>{ mz0f{r<Enter>i{<Esc>`z
" Move end brace to next line
nnoremap <LEADER>} mz0f}r<Enter>i}<Esc>`z
" Terminal run current line as command
nnoremap <LEADER>tb yy:!<C-r>"<BS><Enter>
" Write buffer and return to shell
nnoremap <LEADER>tz :w<Enter><C-z>
" Append '.0f' to flaot
nnoremap <LEADER>f ea.0f<Esc>

" }}}
" Splitting/Joining Lines {{{

" don't add an additional space when joining lines
set nojoinspaces

" https://www.reddit.com/r/vim/comments/3kcu6e/remapping_k_to_split_lines/
nmap K i<CR><Esc>d^==kg_lD
" }}}
" Whitespace {{{

" Trailing whitespace
" Show trailing whitespace only after some text (ignores empty lines):
" /\(\S\+\)\@<=\s\+$
" Remove trailing whitespace from line
" nnoremap <silent> <F5> :let _s=@/<Bar>:s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" Remove trailing whitespace from line, and convert tabs to spaces
nnoremap <silent> <F5> :let _s=@/<Bar>:s/\s\+$//e<Bar>:s/\t/\ \ \ \ /g<Bar>:let @/=_s<Bar>:nohl<CR>

" Listchars
set listchars=nbsp:·,trail:·,eol:¬,precedes:«,extends:»,tab:▸\
" set listchars=nbsp:·,tab:⟶\ ,trail:·,eol:¬
if has("patch-7.4-711")	" This works as of Vim 7.4.711
set listchars+=space:␣
endif
" Toggle viewing listchars
nnoremap <silent> <LEADER>. :set nolist!<CR>

" http://stackoverflow.com/questions/19233184/vim-using-listchars-to-show-leading-whitespace#comment28479060_19233184
" http://stackoverflow.com/questions/1675688/make-vim-show-all-white-spaces-as-a-character
let g:whitespace_syntax_type = 0
function! ToggleWhitespaceSyntax()
   if g:whitespace_syntax_type == 0
      let g:whitespace_previous_syntax=&syntax
      set syntax=whitespace
      let g:whitespace_syntax_type = 1
   else
      let &syntax=g:whitespace_previous_syntax
      let g:whitespace_syntax_type = 0
   endif
endfunction

" http://dougblack.io/words/a-good-vimrc.html
" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
" }}}
" Searching {{{
" After searching, press Ctrl-o to jump back to your previous position (then Ctrl-i will jump forwards).
set incsearch	" do incremental searching
set ignorecase
set smartcase	" ignore case in search unless search contains uppercase
set hlsearch	" highlight matches
" clear search highlighting
nnoremap <silent> <LEADER>/ :nohlsearch<CR>

" git conflict seperator search
nnoremap <LEADER>c /<<<<<<<\\|=======\\|>>>>>>><CR>

" WORD equivalent to * and #
nnoremap q* /<C-r><C-a><CR>
nnoremap q# ?<C-r><C-a><CR>
" }}}
" Disable Some Navigation {{{
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <M-b> <S-Left>
cnoremap <M-r> <S-Right>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" }}}

" highlight last inserted text
nnoremap gV `[v`]

" TODO:
" * https://github.com/ktonga/vim-follow-my-lead show list of all leader keys
" * create shortcut/function to map a keycommand to open the current filetypes
"   ftplugin

" Debugging
" :verbose map [keycombo] OR :map [keycombo]
