" general
set nocp " get out of horrible vi-compatible mode

sil! call pathogen#infect()

filetype indent plugin on " load filetype plugins
syntax enable             " syntax highlighting on

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

" backups
set backup                                 " make backup file
set backupdir^=${HOME}/tmp/vimfiles//      " where to put backup file
set directory^=${HOME}/tmp/vimfiles//      " directory is the directory for temp file
"set makeef^=${HOME}/tmp/vimfiles/error.err " When using make, where should it dump the file

if has('persistent_undo')
  set undodir^=${HOME}/tmp/vimfiles//
  set undofile
  set ul=1000
endif

"set autochdir
"cnoremap cwd :lcd %:p:h

" spelling & thesaurus
if has("spell")
  set spl=en_us
  set spf=${HOME}/tmp/vimfiles/custom_words.en_us.utf-8.add
  nnoremap <leader>s :set spell!<CR>
  set tsr+=${HOME}/.vim/mthesaur.txt 
endif

" wild menu
set wmnu wim=list:longest,full wig=*.o

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
  set fen fdm=syntax fdls=0
endif

" taglist plugin options
let Tlist_Use_Right_Window=1     " split to the right side of the screen
let Tlist_Compart_Format=1       " show small menu
let Tlist_Exist_OnlyWindow=1     " if you are the last, kill yourself
"let Tlist_File_Fold_Auto_Close=0 " do not close tags for other files
let Tlist_Enable_Fold_Column=0   " do not show folding tree

" ctags
"set tags=tags;/ " for recursive search for a tags file named tags up to root
"set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/solinet
"set tags+=~/.vim/tags/solimath
"set tags+=~/.vim/tags/slate
"set tags+=~/.vim/tags/tadil
"set tags+=~/.vim/tags/dis
"set tags+=~/.vim/tags/msct

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
