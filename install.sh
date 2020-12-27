brew bundle

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
