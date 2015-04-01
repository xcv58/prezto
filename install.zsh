#!/bin/zsh
setopt EXTENDED_GLOB
SCRIPT_FILE=$0
SCRIPT_PATH=$(dirname $SCRIPT_FILE)
source ${SCRIPT_PATH}/base.zsh

TARGET="${HOME}/.zprezto"
link_dir ${0} ${TARGET}

for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  echo ln -fs "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  ln -fs "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
