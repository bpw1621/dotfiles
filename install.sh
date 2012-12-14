#!/bin/bash

DOTS=( 'bashrc' 'bash_alias' 'bash_function' 'bash_profile' 'cshrc' 'inputrc' 'vimrc' 'gitconfig' )
for DOT in ${DOTS[@]}; do
  [ -L "${HOME}/.${DOT}" ] && (unlink "${HOME}/.${DOT}")
  [ -f "${HOME}/.${DOT}" ] && (mv "${HOME}/.${DOT}" "${HOME}/${DOT}.bak")
  ln -s "${HOME}/.dotfiles/${DOT}" "${HOME}/.${DOT}"
done

DOTDIRS=( 'vim' 'bc' )
for DOTDIR in ${DOTDIRS[@]}; do
  [ -L "${HOME}/.${DOTDIR}" ] && (unlink "${HOME}/.${DOTDIR}")
  [ -d "${HOME}/.${DOTDIR}" ] && (mv "${HOME}/.${DOTDIR}" "${HOME}/${DOTDIR}.bak")
  ln -s "${HOME}/.dotfiles/${DOTDIR}" "${HOME}/.${DOTDIR}"
done

