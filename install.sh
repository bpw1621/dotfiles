#!/bin/bash

DOTS=( 'bashrc' 'alias_bash' 'function_bash' 'cshrc' 'inputrc' 'vimrc' 'gitconfig' )
for DOT in ${DOTS[@]}; do
  ln -s "dotfiles/${DOT}" "${HOME}/.${DOT}" 
done

DOTDIRS=( 'vim' 'bc' )
for DOTDIR in ${DOTDIRS[@]}; do
  ln -s "dotfiles/${DOTDIR}" "${HOME}/.${DOTDIR}" 
done

ln -s .bashrc .bash_profile
