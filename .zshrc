# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
#
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="miloshadzic"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  asdf
  brew
  bundler
  chruby
  gem
  git
  ruby
)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/usr/local/bin:/bin:/usr/sbin:/sbin:/usr/bin:$PATH"
PATH=$PATH:"$HOME/Library/Android/sdk/platform-tools"
unsetopt nomatch

# rbenv configuration
# export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
# eval "$(rbenv init -)"

# chruby configuration
# chruby ruby-2.6.6
# source /usr/local/share/chruby/chruby.sh
# source /usr/local/share/chruby/auto.sh

# Golang configuration
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Oracle configuration
export PATH="/opt/instaclient:$PATH"
export DYLD_LIBRARY_PATH="/opt/instaclient/:$DYLD_LIBRARY_PATH"
export PKG_CONFIG_PATH=/opt/instaclient/pkgconfig

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
