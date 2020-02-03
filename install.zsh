#!/bin/zsh
setopt EXTENDED_GLOB
SCRIPT_FILE=$0
SCRIPT_PATH=$(dirname $SCRIPT_FILE)
source ${SCRIPT_PATH}/base.zsh

TARGET="${HOME}/.zprezto"
link_dir ${0} ${TARGET}

# source ${SCRIPT_PATH}/link-dot-files.zsh
source "${ZDOTDIR:-$HOME}"/.zprezto/link-dot-files.zsh
