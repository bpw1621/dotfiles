" Vim syntax file
" Language:	C++
" Maintainer:	Ken Shan <ccshan@post.harvard.edu>
" Last Change:	2002 Jul 15

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
"
"-------------------------------------------------------------------------
"
" Add the following lines to your .vimrc, and uncomment them, of course:
" au BufRead,BufNewFile *.mph set filetype=metaphor
" 
" au! Syntax metaphor source $HOME/.vim/metaphor.vim
"
"-------------------------------------------------------------------------

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Read the C syntax to start with
if version < 600
  so <sfile>:p:h/cpp.vim
else
  runtime! syntax/cpp.vim
  unlet b:current_syntax
endif

" syn region mphAugment          start="^\s*augment " end="^\s*end augment"
syn match   mphAugment          "^\s*augment\s*"
syn match   mphAugment          "^\s*end\s*augment\s*"
syn match   mphAugbody          "[HC].body\s*"
syn match   mphAugbody          "[HC].preamble\s*"
syn match   mphAugbody          "Java.[body|javadoc]\s*"

syn match   mphAugment          "^\s*replace\s*"
syn match   mphAugment          "^\s*end\s*replace\s*"
syn match   mphAugbody          "H.constructors\s*"
syn match   mphAugbody          "C.constructor\s*"

syn match   mphType             "^\s*bitfield\s*"
syn match   mphType             "^\s*end\s*bitfield\s*"
syn match   mphType             "^\s*end\s*class\s*"
syn match   mphType             "^\s*end\s*enum\s*"

syn keyword mphStatement        bits etag member
syn keyword mphType             u_char s_char u_int u_long u_short
syn keyword pmrfType            VID_t SID_t

" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
  if version < 508
    let did_cpp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink mphAugment             Operator
  HiLink mphAugbody             Statement
  HiLink mphOperator            Operator
  HiLink mphStatement           Statement
  HiLink mphType                Type
  HiLink pmrfType               Type
  delcommand HiLink
endif

let b:current_syntax = "mph"

" vim: ts=8
