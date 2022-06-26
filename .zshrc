# Created by newuser for 5.2
# Initialize zplug
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

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

# for Mac OS
# If you want to apply only Mac OS, write on this block.
if [ `uname` = 'Darwin' ] ;then
        export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
        alias ls='ls -G'
else
        alias ls='ls --color=auto'
fi

# Define alias
## alias (ls)
alias ll='ls -l'
alias la='ls -a'
alias lal='ls -al'
# alias (git)
alias ga='git add'
alias gu='git add -u'
alias gd='git diff'
alias gs='git status'
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
#Key bind for reverse complete
bindkey '^[[Z' reverse-menu-complete
zstyle ':completion:*:default' menu select=2
#Completion colors setting
zstyle ':completion:*' list-colors di=44 ln=35 ex=32
#Define shell function

#zle -N peco-history-selection
#bindkey '^R' peco-history-selection

#Prompt Settigs
#RPROMPT="[%{$fg[magenta]%}%~%{$reset_color%}]"
RPROMPT="[%F{magenta}%~%f]"
#PROMPT="%n@%m%{%(?.$fg[green].$fg[red])%}%#%{$reset_color%}"
#Show git branch on console
##Setting vcs_info view
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "(%c%u%F{green}%b%f%)" 
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
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# export PYENV_ROOT="${HOME}/.pyenv"
# export PATH="${PYENV_ROOT}/bin:${PATH}"
export PATH="/usr/local/sbin:$PATH"

# initialize pyenv
if (which pyenv > dev/null 2>&1); then
  eval "$(pyenv init -)"
fi

#for mizar
#export MIZFILES=/usr/local/share/mizar
#export PATH="/usr/local/sbin:$PATH"
fpath=(/usr/local/share/zsh-completions $fpath)

#for neovim:dein.vim
export XDG_CONFIG_HOME=~/.config

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi
function gi() { curl -sLw "\n" https://gitignore.io/api/$@ ;}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

