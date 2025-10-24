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
  # asdf
  brew
  bundler
  # chruby
  gem
  git
  ruby
  rails
)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/opt/homebrew/bin:/usr/local/bin:/bin:/usr/sbin:/sbin:/usr/bin:$PATH"
PATH=$PATH:"$HOME/Library/Android/sdk/platform-tools"
PATH=$PATH:"$HOME/dev/kevin-j-m/dotfiles/bin"
unsetopt nomatch

# asdf configuration
# set one of these in ~/.zshrc.local
#
# Intel Mac OS
# . /usr/local/opt/asdf/asdf.sh
# M1
# . /opt/homebrew/opt/asdf/libexec/asdf.sh

# rbenv configuration
# export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
# eval "$(rbenv init -)"

# chruby configuration
# chruby ruby-2.6.6
# source /usr/local/share/chruby/chruby.sh
# source /usr/local/share/chruby/auto.sh

# GPG setup
export GPG_TTY=$(tty)

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
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

source $HOME/.aliases

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

timezshplugin() {
  # Load all of the plugins that were defined in ~/.zshrc
  for plugin ($plugins); do
    timer=$(($(gdate +%s%N)/1000000))
    if [ -f $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh ]; then
      source $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh
    elif [ -f $ZSH/plugins/$plugin/$plugin.plugin.zsh ]; then
      source $ZSH/plugins/$plugin/$plugin.plugin.zsh
    fi
    now=$(($(gdate +%s%N)/1000000))
    elapsed=$(($now-$timer))
    echo $elapsed":" $plugin
  done
}

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

source "${HOME}/.zshrc.local"
