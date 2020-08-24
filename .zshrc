# Created by newuser for 5.2
# Initialize zplug
source ~/.zplug/init.zsh

#autoload self made plugin
fpath=(~/.zsh/functions/*(N-/) $fpath)
autoload -Uz Runruby
autoload -Uz Runjava
autoload -Uz Ccompile
autoload -Uz Compilelex
autoload -Uz CompileTex
autoload -Uz RunPython
autoload -Uz peco-history-selection
#autoload using plugin
autoload -Uz vcs_info
autoload -U colors 

# Define alias
## alias (ls)
alias ls='ls -G'
alias ll='ls -l'
alias la='ls -a'
alias lal='ls -al'
# alias (git)
alias ga='git add'
#To Use Ruby in rbenv
alias gem='rbenv exec gem'

# alias (vim)
alias vim='nvim'


# Define extension alias
alias -s {c,cpp}=Ccompile
alias -s java=Runjava
alias -s rb=Runruby
alias -s l=Compilelex
alias -s tex=CompileTex
alias -s py=RunPython

#Export variables
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=10000
#Export LSCOLORS for Mac OS X (used by ls -G)
export LSCOLORS=xefxcxdxbxegedabagacad

#export variables for Ruby
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"


#Define Options
setopt AUTO_CD
setopt CORRECT
setopt HIST_IGNORE_ALL_DUPS
setopt PROMPT_SUBST

#Define Completion highlight
autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=2
#Completion colors setting
zstyle ':completion:*' list-colors di=44 ln=35 ex=32
#Define shell function

zle -N peco-history-selection
bindkey '^R' peco-history-selection

#Prompt Settigs
#RPROMPT="[%{$fg[magenta]%}%~%{$reset_color%}]"
RPROMPT="[%F{magenta}%~%f]"
#PROMPT="%n@%m%{%(?.$fg[green].$fg[red])%}%#%{$reset_color%}"
#Show git branch on console
##Setting vcs_info view
zstyle ':vcs_info:*' formats "(%F{green}%b%f%)" 
zstyle ':vcs_info:*' actionformats "(* %F{green}%b%f[%F{red}%a%f]%)" 

precmd(){ 
	local message
	LANG=en_US.UTF-8 vcs_info
	[[ -n "${vcs_info_msg_0_}" ]] && message="${vcs_info_msg_0_}"
	PROMPT="%n${message}%{%(?.%F{green}.%F{red})%}%#%f"
}
#Define plugin (zplug)
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"

#zplug install
if ! zplug check --verbose; then
  printf 'Install? [y/N]: '
  if read -q; then
    echo; zplug install
  fi
fi

zplug load --verbose

# Please comment out unless using Mac OS
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init -)"

#for mizar
export MIZFILES=/usr/local/share/mizar
export PATH="/usr/local/sbin:$PATH"
fpath=(/usr/local/share/zsh-completions $fpath)

#for neovim:dein.vim
export XDG_CONFIG_HOME=~/.config
