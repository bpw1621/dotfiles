" general
set nocp " get out of horrible vi-compatible mode

sil! call pathogen#infect()

if has('autocmd')
  filetype indent plugin on
endif

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

set history=1000       " How many lines of history to remember
set cf                 " enable error files and error jumping
set clipboard+=unnamed " turns out I do like sharing windows clipboard
set ffs=unix,dos,mac   " support all three, in this order
set viminfo+=!         " make sure it can save viminfo
set isk+=_,$,@,%,#,-   " none of these should be word dividers, so make them not be
set enc=utf-8          " use UTF-8 encoding
set t_Co=256           " this terminal has 256 colors

if has("gui_running")
  if has("unix")
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 18
  elseif has("win32")
    set guifont=Consolas:h18:cANSI
  endif
endif

" theme
set bg=dark
sil! colo diablo3

set ar aw

if isdirectory(expand('~/.cache/vim'))
  if &dir =~# '^\.,'
    set dir^=~/.cache/vim/swap//
  endif
  if &bdir =~# '^\.,'
    set bk
    set bdir^=~/.cache/vim/backup//
  endif
  if exists('+undofile') && exists('+undodir') && &undodir =~# '^\.\%(,\|$\)'
    set undofile
    set undodir^=~/.cache/vim/undo//
    set ul=1000
  endif
  if exists('+quickfix')
    set mef^=~/.cache/vim/make.log
  endif
  if has("spell")
    set spl=en_us
    set spf^=~/.cache/vim/custom_words.en_us.utf-8.add
    set tsr+=~/.cache/vim/mthesaur.txt
  endif
endif

if exists('+autochdir')
  set autochdir
endif

" wild menu
set wmnu wim=list:longest,full wig=CVS,.git,*.o,*.class,*.la,*.so,*.obj,*.swp

set lsp=0              " space it out a little more (easier to read)
set ru                 " Always show current positions along the bottom
set cmdheight=2        " the command bar is 2 high
set nu                 " turn on line numbers
set lz                 " do not redraw while running macros (much faster) (LazyRedraw)
set hid                " you can change buffer without saving
set backspace=2        " make backspace work normal
set whichwrap+=<,>,h,l " backspace and cursor keys wrap to
set shortmess=atI      " shortens messages to avoid 'press a key' prompt
set report=0           " tell us when anything is changed via :...
set ss=1               " sidescroll behavior for fast terminals (stops the jumping when off screen with nowrap)

set noek ttimeout tm=1000 ttm=100

if has('mouse')
  set mouse=a            " use mouse everywhere
endif

" make the splitters between windows be blank
"set fillchars=vert:\ ,stl:\ ,stlnc:\

" visual cues
set sm " show matching brackets
set novb noeb " don't blink & no noises
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2 " always show the status line
set statusline=%f\ %{fugitive#statusline()}\ [line\ %l\/%L]
hi StatusLine ctermfg=Black ctermbg=White
au InsertEnter * hi StatusLine ctermbg=White ctermfg=DarkRed
au InsertLeave * hi StatusLine ctermbg=White ctermfg=Black

hi ExtraWhitespace ctermbg=red guibg=red
mat ExtraWhitespace /\s\+$/
au BufWinEnter * mat ExtraWhitespace /\s\+$/
au InsertEnter * mat ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * mat ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

" what to show when I set list
set listchars=tab:»·,trail:·,extends:>,precedes:<,eol:¬

" text formatting/layout
set fo=crqn                     " format options
set cot=menuone,longest,preview " complete options
set nowrap                      " do not wrap lines

let c_no_curly_error=1 " fixes the C++0x issue with braces and lambdas

set et sta ts=2 sts=2 sw=2 " tab
set ai si cin ci           " indenting
set hls is ic scs          " search

" folding
if exists("&fen")
  set fen fdm=syntax fdl=99 fdls=99
endif

" clang_complete
"let g:clang_exec="${HOME}/local/bin/clang"
"let g:clang_library_path="${HOME}/local/lib/libclang.so"

" mappings

" toggles
nnoremap <leader>l :set list!<CR>
nnoremap <leader>w :set wrap!<CR>
nnoremap <leader>h :nohls<CR>
nnoremap <leader>t :Tlist<CR>
nnoremap <leader>e :Vex<CR>
nnoremap <leader>v :e $MYVIMRC<CR>
nnoremap <leader>c :set cuc! cul!<CR>
nnoremap <leader>s :set spell!<CR>
set pt=<leader>p

" Map Q -> gq (better ex mode)
nnoremap Q gq
vnoremap Q gqap

nnoremap Y y$

" Remappings
nnoremap <Space> <PageDown>
nnoremap <S-Space> <PageUp>

fu! CompileAndRunCppFile()
  exec "!g++ % -o %< && %<"
endf
nnoremap <leader>m :call CompileAndRunCppFile()<CR>

set tw=80
if exists("&cc")
  set cc=0
  fu! ToggleLongLines()
    "let limit = (&tw ? &tw : 80)
    if &cc=='0'
      set cc=+1
      hi OverLength ctermfg=red gui=undercurl guisp=darkred
      match OverLength /\%81v.*/
    else
      set cc=0
      hi clear OverLength
    endif
  endf
  nnoremap <leader>f :call ToggleLongLines()<CR>
endif

" autocommands
autocmd BufEnter * :syntax sync fromstart " ensure full syntax highlighting
autocmd BufWritePost .vimrc so %

" abbrevs
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
