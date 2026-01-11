#!/usr/bin/env zsh


# The order of loading
# 1. ~/.zsh/.zprofile
# 2. ~/.zsh/.zshrc
# 3. ~/.zshrc_env
# 4. ~/.zshrc_private

###################
# Check .zprofile #
###################
if [[ -z $(alias | grep zsh_profile_loaded) ]]; then
  source $ZDOTDIR/.zprofile
fi

# Load modular configurations
for module in $ZDOTDIR/modules/*.zsh; do
  [[ -f $module ]] && source $module
done

autoload -Uz colors && colors
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT='${vcs_info_msg_0_}'
# PROMPT='${vcs_info_msg_0_}%# '
zstyle ':vcs_info:git:*' formats '%b'

# Autoload user defined completion functions
autoload -Uz gitutils && gitutils

export EDITOR=nvim
eval "$(direnv hook zsh)"

PROMPT='%F{cyan}%n%f@%m %F{yellow}%~%f%F{red} ${vcs_info_msg_0_} %f
$ '

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias zsh_rc_loaded='echo "zsh_rc_loaded"'
