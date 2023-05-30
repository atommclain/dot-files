" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup		" keep backup files
set backupdir=~/.tmp,~/
set directory=~/.tmp,~/

set autoread		" reload files when changed outside of Vim
set history=50		" keep 50 lines of command line history
set number		" show line number
set hidden		" allow buffers to be hidden without write
set scrolloff=6		" start scrolling at 6 lines from edge
set wrap		" soft wrap on edge of window (default on)
set breakindent		" lines that wrap keep previous indentation
set linebreak		" wrap lines without inserting newline
set gdefault		" by default substitutions have 'g' flag
set modeline		" turn on modelines
set modelines=5
set ttimeoutlen=10
set splitright
set splitbelow
set shiftround

filetype on
filetype indent on	" load filetype-specific indent files
filetype plugin on
set background=dark
set laststatus=2	" always show the statusline
set encoding=utf-8	" necessary to show Unicode glyphs
set clipboard=unnamed	" use system clipboard
set iskeyword-=_	" don't count `_` as part of a 'word'
set wildignore+=*.o,*.obj,*.a,*.lib,*.elf,*.dll,*.exe " ignore binaries
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.png,*.html,*.doc,*.md5
set wildignore+=*.mobileprovision,*.py,*.js,*.png,*.sh,*.entitlements,*.plist,*.pch,*.json,*.rb

set printoptions=number:y,left:5pc,paper:letter
set printfont=MesloLGM\ Nerd\ Font:h9

set showmatch		" highlight matching [{()}]
set matchtime=1		" 1/10s timeout to find match
" Visual selection of current line minus indentation, blockwise
nnoremap vv ^<C-v>g_

" Boolean values for terminal/OS logic
let os=substitute(system('uname'), '\n', '', '')
let hostname=substitute(system('hostname'), '\n', '', '')
let OSXTerminal=(os == 'Darwin' || os == 'Mac') && $TERM_PROGRAM == "Apple_Terminal"
let linuxConsole = (g:os == "Linux" && $TERM != "xterm-256color")
let linuxXterm = (g:os == "Linux" && $TERM == "xterm-256color")
let slowVim = hostname == "ereader" || $SHELL == "/bin/ash"
let sixteenColor = $SHELL == "/bin/ash"

if slowVim
  set synmaxcol=200	" stop highlighting after 200 columns
endif

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

" Maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir

" will buffer screen updates instead of updating all the time

" Show diff to a file, use :diffoff to turn off
 if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
\ | wincmd p | diffthis
endif

" Auto Command Groups {{{
augroup vimrcEx
  au!
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78 expandtab shiftwidth=4
  autocmd FileType yaml setlocal sts=2 sw=2
  autocmd FileType sh setlocal ts=4 sts=4 sw=4 et

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
  autocmd BufReadPost .gvimrc setlocal noexpandtab
  " Source the vimrc file after saving it
  autocmd bufwritepost .vimrc source $MYVIMRC
  autocmd bufwritepost .vimrc silent! :AirlineRefresh

  " Source .tmux.conf on save
  autocmd bufwritepost .tmux.conf silent! :call system('tmux source-file ~/.tmux.conf &')
  " Open files with folds open
  autocmd BufWinEnter * silent! :%foldopen!

  autocmd BufReadPost Podfile setlocal filetype=ruby
  autocmd BufReadPost Fastfile setlocal filetype=ruby
  autocmd BufReadPost Appfile setlocal filetype=ruby

  " Private files don't write to disk https://vi.stackexchange.com/a/6678
  au BufRead *.private setlocal history=0 nobackup noshelltemp noswapfile noundofile nowritebackup secure viminfo=""
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

if !slowVim
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
    au WinLeave * setlocal nocursorline
    au WinLeave * setlocal nocursorcolumn
augroup END
endif

augroup Ledger
  au!
  " insert todays date
  autocmd FileType ledger nnoremap <silent> <buffer> <localleader>t :read !date +"\%Y/\%m/\%d"<CR>A !<ESC>
  " insert yesterdays date
  autocmd FileType ledger nnoremap <silent> <buffer> <localleader>y :read !date -r $((`date +\%s` - 86400)) +"\%Y/\%m/\%d"<CR>A *<ESC>
  " toggle transaction state betweeen * and !
  autocmd FileType ledger nnoremap <silent> <buffer> <localleader>a :call ledger#transaction_state_toggle(line('.'), '*!')<CR>
  " insert mta fare
  "autocmd FileType ledger nnoremap <silent> <buffer> <localleader>m :read !date +"\%Y/\%m/\%d"<CR>A * MTA<CR>mta<TAB><TAB><TAB><TAB><TAB><TAB><TAB>$2.75<CR>alaska<CR><ESC>
  autocmd FileType ledger nnoremap <silent> <buffer> <localleader>m :read !date -r $((`date +\%s` - 86400)) +"\%Y/\%m/\%d"<CR>A * MTA<CR>mta<TAB><TAB><TAB><TAB><TAB><TAB><TAB>$2.75<CR>alaska<CR><ESC>
  " move cursor to day in yyyy/mm/dd
  autocmd FileType ledger nnoremap <silent> <buffer> <localleader>dd 04w
  " make date today
  "autocmd FileType ledger nnoremap <silent> <buffer> <localleader>dt 0dW:read !date +"\%Y/\%m/\%d"<CR>
  autocmd FileType ledger nnoremap <silent> <buffer> <localleader>dt 0dW:read !echo -n `date +"\%Y/\%m/\%d"`<CR>

  au FileType ledger 1SpeedDatingFormat %Y%[/-]%m%1%d
augroup END
" }}}

" Plugins {{{

" Pathogen
if filereadable(expand("~/.vim/autoload/pathogen.vim"))
  execute pathogen#infect()
  syntax on
  filetype plugin indent on
endif

set runtimepath^=~/.vim/bundle/ctrlp.vim

if filereadable(expand("~/.vim/autoload/pathogen.vim"))
" Solarize
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" if &t_Co > 2 || has("gui_running")
  if g:os == "Linux"
    let g:solarized_termcolors=256
  endif
  colorscheme solarized
  if linuxConsole
    colorscheme nord
  endif
  if sixteenColor
    colorscheme slate
    let g:airline_theme='nord'
  endif
" endif
endif

" Airline
let g:airline#extensions#tabline#enabled = 1
if OSXTerminal || has("gui_macvim")
  let g:airline_powerline_fonts = 1
endif

if has("macunix")
" Italics support
  let &t_ZH="\e[3m"
  let &t_ZR="\e[23m"
  highlight Comment cterm=italic gui=italic
" mouse support
  if !has('nvim')
    set ttymouse=xterm2
  endif
  set mouse=a
endif

"if !exists('g:airline_powerline_fonts')
"    let g:airline_left_sep='›'
"    let g:airline_right_sep='‹'
"airline…
"showfonts…
"endif
if linuxConsole
  let g:airline_symbols_ascii = 1
endif
if linuxXterm
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.whitespace = 'Ξ'
endif
if slowVim
  let g:airline_theme='dark_minimal'
  let g:airline_highlighting_cache = 1
endif

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
" let mapleader = "\<space>"
let maplocalleader = "["

" Insert space
nnoremap <LEADER><SPACE> i <Esc>l
" Insert new line below and return to line
nnoremap <LEADER><CR> mzo<Esc>`z
" Insert new line above and return to line
nnoremap <LEADER><S-CR> mzO<Esc>`z

" Setup command for unnamed register
nnoremap <LEADER>- "_
vnoremap <LEADER>- "_

" Insert line of "="
nnoremap <LEADER>= o<ESC>40i=<ESC>
" Insert line of "-"
nnoremap <LEADER>- o<ESC>40i-<ESC>
" Add semi colon to the end of current line
nnoremap <LEADER>; mzA;<ESC>`z
" A.vim alternative file
nnoremap <LEADER>a <ESC>:A<CR>
" Buffer management: list buffers
nnoremap <LEADER>b :buffers<CR>:buffer<Space>
" Buffer management: delete current buffer
nnoremap <LEADER>d :bd<CR>
" Buffer management: delete current buffer discarding changes
nnoremap <LEADER>D :bd!<CR>
" Buffer management: delete current buffer without closing window
nnoremap <LEADER>bc :bp<bar>sp<bar>bn<bar>bd<CR>
" Buffer management: next buffer
nnoremap <LEADER>n :bn<CR>
" Buffer management: previous buffer
nnoremap <LEADER>p :bp<CR>
" Edit .vimrc
nnoremap <LEADER>ev :e $MYVIMRC<CR>
" Edit .gvimrc
nnoremap <LEADER>eg :e $MYGVIMRC<CR>
" Reload .vimrc
nnoremap <LEADER>vs :so $MYVIMRC<CR>:nohlsearch<CR>:echom ".vrimrc sourced"<CR>
"Fugitive
nnoremap <LEADER>gd :Gdiff<CR>
nnoremap <LEADER>go <C-W><C-O>:diffoff<CR>
nnoremap <LEADER>gs :Gstatus<CR>
" Run marco stored in q register
nnoremap <LEADER>q @q
" yank line without whitespace, paste into ex command line
nnoremap <LEADER>r ^yg_:!<C-r>"
" Split line before cursor
nnoremap <LEADER>s hmzli<Enter><Esc>`z
" Split line after cursor
nnoremap <LEADER>S mza<Enter><Esc>`z
" Terminal run current line as command
nnoremap <LEADER>tb yy:!<C-r>"<BS><Enter>
" Write buffer and return to shell
nnoremap <LEADER>tz :w<Enter><C-z>
" Write q register to vimrc
nnoremap <LEADER>wq :call ADMSaveQMacro()<CR>
" Insert Date
nnoremap <LEADER>id o<ESC>:read !date +"\%Y/\%m/\%d \%A"<CR>o<ESC>40i-<ESC>j0

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
" Remove trailing whitespace from line, and convert tabs to 4 spaces
nnoremap <silent> <F5> :let _s=@/<Bar>:s/\s\+$//e<Bar>:s/\t/\ \ \ \ /g<Bar>:let @/=_s<Bar>:nohl<CR>

" Nice vertical split
hi VertSplit ctermbg=None
set fillchars+=vert:│

" Listchars
set listchars=nbsp:∅,trail:·,eol:¬,precedes:«,extends:»,tab:▸›
if has("patch-7.4-711")	" This works as of Vim 7.4.711
  set listchars+=space:␣
endif
if linuxConsole
  set listchars=nbsp:∅,trail:ж,eol:¬,precedes:«,extends:»,tab:┣→
  if has("patch-7.4-711")	" This works as of Vim 7.4.711
    set listchars+=space:·
  endif
endif

" Toggle viewing listchars ⇥
nnoremap <silent> <LEADER>. :set list!<CR>
nnoremap <silent> <LEADER>, :set nolist number! <BAR> AirlineToggle <BAR> nohlsearch<CR>
"set showbreak=↪\ 	" indicator to show wrapped line
"let g:airline_section_z = "%p%% %l %v %{strlen(getline('.'))}"		" show real linke length
"let g:airline_section_z = "%3p%% %#__accent_bold#%{g:airline_symbols.linenr}%4l%#__restore#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__# :%3v %{strlen(getline('.'))}"		" show real line length with default formatting

" quick highlight
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

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

" Super search
" https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86
nnoremap <LEADER>f :g//#<Left><Left>
function! CCR()
    " grab the current command-line
    let cmdline = getcmdline()
    " does it end with '#' or 'number' or one of its abbreviations?
    if cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
        " press '<CR>' then ':' to enter command-line mode
        return "\<CR>:"
    else
        " press '<CR>'
        return "\<CR>"
    endif
endfunction
" map '<CR>' in command-line mode to execute the function above
cnoremap <expr> <CR> CCR()
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
" Macros {{{
"
" insert literal register <C-r><C-r>[register]
" insert special characters with <C-v>[special]
" There are issues with registers that end in a <CR> or <NL>
" setreg vs let @q = difference in let '' vs let ""

function! ADMSHOHit()
  execute "s/%20/ /"
  execute "s/%2C/,/"
  execute "s/%5B/[/"
  execute "s/%5D/]/"
  execute "s/%3A/:/"
  execute "s/?/\r/"
  normal! j
  execute "s/&/\r/"
  execute "%sort"
endfunction

" Used to pretify profile.log generated from alias profvim
command! -bar ADMProfileTiminings let timings=[]
command! -bar ADMProfileg g/^SCRIPT/call add(timings, [getline('.')[len('SCRIPT  '):], matchstr(getline(line('.')+1), '^Sourced \zs\d\+')]+map(getline(line('.')+2, line('.')+3), 'matchstr(v:val, ''\d\+\.\d\+$'')'))
command! -bar ADMProfileNew enew
command! -bar ADMProfileLine call setline('.', ['count total (s)   self (s)  script']+map(copy(timings), 'printf("%5u %9s   %8s  %s", v:val[1], v:val[2], v:val[3], v:val[0])'))
command! ADMProfile ADMProfileTiminings|ADMProfileg|ADMProfileNew|ADMProfileLine

" saved macros  -- place cursor below then call Loadqregister to load it
" Gllllxgvhhhh~lGlx0GIi0"py$@pjqkbj
" Gllllxgvhhhh~lGlx0GIi
" Gllllxgvhhhh~lGlx0GIi0
" 0"py$@pld$j

function! ADMSaveQMacro()
  execute "edit " . $MYVIMRC
  normal! gg
  normal! zR
  let _s=@/
  execute "normal! / saved macros\<CR>"
  let @/=_s
  execute "set textwidth=0"
  execute "set wrapmargin=0"
  execute 'normal! oq'
  " 'noautocmd' allows the next command to run without
  " autocmds, in this case sourcing .vimrc during write
  execute 'noautocmd w'
  execute 'bd'
endfunction

command! Loadqregister :call ADMLoadQRegister()
function! ADMLoadQRegister()
  normal! 0
  normal! w
  normal! "qy$
endfunction

"https://stackoverflow.com/questions/2024443/saving-vim-macros#comment32271394_2024537

function! AdamMacro()
  normal! xx0f,
  " Get current letter.
  normal! yl
  if @" =~# '[,]'
    execute "normal! $xxxxxIUIAlertAction *otherAction = [UIAlertAction actionWithTitle:\<ESC>ostyle:UIAlertActionStyleDefault\<CR>handler:^(UIAlertAction * _Nonnull action) { <#code#> }]; [alert addAction:otherAction];"
  else
    execute "normal! dd"
  endif
endfunction
" }}}

" highlight last inserted text
nnoremap gV `[v`]

command! LoadWork :call ADMLoadWork()
command! WorkLoad :call ADMLoadWork()
function! ADMLoadWork()
  execute "edit ~/Downloads/Work-TODO.txt"
  execute "setlocal foldexpr=WorkTodoFolding()"
  execute "setlocal foldtext=WorkTodoFoldText()"
  execute "60vsp ~/Downloads/scratch.txt"
  normal! G
  normal! h
  execute "tabedit ~/git/dot-files/Setup-New-Computer/mac.txt"
  normal! gt
endfunction

function! WorkTodoFolding()
  let thisline = getline(v:lnum)
  let nextline = getline(v:lnum+1)
  if match(thisline, '\S') >= 0 && match(nextline, '^-----') >= 0
    return '>2'
  elseif match(thisline, '\S') >= 0 && match(nextline, '^=====') >= 0
    return '>1'
  else
    return "="
  endif
endfunction

function! WorkTodoFoldText()
  let indent_level = foldlevel(v:foldstart)
  if indent_level == 1
    let indent = ''
  else
    let indent = repeat(' ',indent_level)
  endif

  let foldsize = (v:foldend-v:foldstart)
  let foldtext = getline(v:foldstart).' ('. foldsize.' lines)'

  return indent . foldtext
endfunction

command! DiffScratchADM :call ADMScratchDiff()
" http://vimcasts.org/episodes/comparing-buffers-with-vimdiff/
function! ADMScratchDiff()
  execute "vsp"
  execute "ene"
  execute "windo diffthis"
  normal! h
  normal! "*p
endfunction
" TODO:
" * https://github.com/ktonga/vim-follow-my-lead show list of all leader keys
" * create shortcut/function to map a keycommand to open the current filetypes
"   ftplugin

" Debugging
" :verbose map [keycombo] OR :map [keycombo]

" A key with the Ctrl key modifier is represented using the <C-key> notation.
" A key with the Shift key modifier is represented using the <S-key> notation.
" A key with the Alt key modifier is represented using <A-key> or <M-key> notation.
" Super is represented <D-key> in MacVim and <T-key> in gtk2 gvim. In gvim it doesn't work with all the keys.

if executable('sourcekit-lsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'sourcekit-lsp',
        \ 'cmd': {server_info->['sourcekit-lsp']},
        \ 'whitelist': ['swift'],
        \ })
    autocmd FileType swift setlocal omnifunc=lsp#complete
    autocmd FileType swift nnoremap <C-]> :LspDefinition<CR>
endif

" https://github.com/vim/vim/issues/4738
if has('macunix')
  function! OpenURLUnderCursor()
    let s:uri = expand('<cWORD>')
    let s:uri = matchstr(s:uri, '[a-z]*:\/\/[^ >,;()]*')
    let s:uri = substitute(s:uri, '?', '\\?', '')
    let s:uri = shellescape(s:uri, 1)
    if s:uri != ''
      silent exec "!open '".s:uri."'"
      :redraw!
    endif
  endfunction
  nnoremap gx :call OpenURLUnderCursor()<CR>
endif

" Universal help
nnoremap <silent> <F12> :botright sp<Bar>:e ~/git/dot-files/help/vim.txt<CR>
