#!/usr/bin/env zsh

# Vi mode configuration for zsh
# Provides a vim-like experience in the shell

# Enable vi mode
bindkey -v

# Cursor shape changes and mode indicator based on vi mode
# Beam cursor in insert mode, block cursor in normal mode
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    # Normal mode - block cursor
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} == '' ]] || [[ $1 = 'beam' ]]; then
    # Insert mode - beam cursor
    echo -ne '\e[5 q'
  fi
  zle reset-prompt
}
zle -N zle-keymap-select

