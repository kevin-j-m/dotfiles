brew bundle

# Finish fzf install
read -p "Do you wish to run the fzf installer (y/n)?" yn
case $yn in
  [Yy]* ) $(brew --prefix)/opt/fzf/install;;
esac

# Symlink kitty terminal config
ln -sv "$PWD/kitty.conf" "$HOME/.config/kitty"

# Symlink brewfile
ln -sv "$PWD/Brewfile" "$HOME"

# Symlink terminal config
ln -sv "$PWD/.aliases" "$HOME"
ln -sv "$PWD/.zshrc" "$HOME"

# Symlink vim config
if [ ! -e $HOME/.vim/autoload/plug.vim ]; then
  curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
vim -u $HOME/.vimrc.bundles +PlugInstall +PlugClean! +qa

ln -sv "$PWD/.vimrc" "$HOME"
ln -sv "$PWD/.vimrc.bundles" "$HOME"

mkdir -p "$HOME/.config/nvim/"
ln -sv "$PWD/init.vim" "$HOME/.config/nvim"

# Symlink git config
ln -sv "$PWD/.gitconfig" "$HOME"
ln -sv "$PWD/.gitmessage" "$HOME"
ln -sv "$PWD/.gitattributes" "$HOME"

git config --global core.attributesfile ~/.gitattributes

# asdf config
ln -sv "$PWD/.asdfrc" "$HOME"
ln -sv "$PWD/.tool-versions" "$HOME"

# set deployment target for erlang
# remove when targeting a more modern erlang release
export MACOSX_DEPLOYMENT_TARGET=10.0
asdf plugin add ruby
asdf plugin add elixir
asdf plugin add erlang
(cd ~; asdf install)
