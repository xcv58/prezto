#!/bin/zsh
setopt EXTENDED_GLOB

for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  echo ln -fs "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  ln -fs "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
