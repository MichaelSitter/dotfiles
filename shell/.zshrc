# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Directories to be prepended to $PATH
declare -a dirs_to_prepend
dirs_to_prepend=(
  "/usr/bin"
  "/usr/local/sbin"
  "usr/local/bin"
  "/usr/local/git/bin"
  "/usr/local/"
  "/usr/local/mysql/bin"
  "/sw/bin/"
  "$HOME/dotfiles/bin"
  "$HOME/bin"
  "$HOME/.jenv/bin"
  "$HOME/gocode/bin"
  "$(brew --prefix ruby)/bin"
  "$(brew --prefix)/share/npm/bin" # Add npm-installed package bin
  "`yarn global bin`"
)

# Explicitly configured $PATH
PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

for dir in ${(k)dirs_to_prepend[@]}
do
  if [ -d ${dir} ]; then
    # If these directories exist, then prepend them to existing PATH
    PATH="${dir}:$PATH"
  fi
done

unset dirs_to_prepend

export PATH

source $ZSH/oh-my-zsh.sh

###########################
# oh-my-zsh settings - https://github.com/robbyrussell/oh-my-zsh/blob/master/templates/zshrc.zsh-template
###########################
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
ZSH_THEME="agnoster"

#  https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins
plugins=(
	git
	node
	npm
	brew
	golang
	yarn
	nvm
	docker
	gradle
	pyenv
	virtualenv
)

###########################
# User configuration
###########################

export GOPATH="$HOME/gocode"
export RBENV_ROOT=/usr/local/var/rbenv
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig

# npm tab completion
. <(npm completion)

# nvm - https://github.com/creationix/nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

# jenv - https://github.com/gcuisinier/jenv
eval "$(jenv init -)"

# Keybindings
bindkey -e
bindkey '[C' forward-word
bindkey '[D' backward-word

# Aliases
alias git-master='git add -A && git stash && git co master && git pull'
alias git-latest='git add -A && git stash && git pull && git stash pop'
alias gredo='git add -A && git commit --amend --no-verify --no-edit && git push -f'
alias docker-stopall='docker kill $(docker ps -q)'
alias docker-rm='docker rm $(docker ps -a -q)'
alias docker-rmi='docker rmi $(docker images -q)'

source $ZSH/oh-my-zsh.sh

# Source local extra (private) settings specific to machine if it exists
[ -f ~/.zsh.local ] && source ~/.zsh.local
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/opt/openssl/bin:$PATH"
