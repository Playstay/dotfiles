export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if [[ $OSTYPE =~ 'darwin' ]];then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(pyenv init --path)"
fi
