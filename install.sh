brew bundle

# Symlink dotfiles
ln -sv "$PWD/.aliases" "$HOME"
ln -sv "$PWD/.zshrc" "$HOME"

mkdir -p "$HOME/.config/nvim/"
ln -sv "$PWD/init.vim" "$HOME/.config/nvim"

ln -sv "$PWD/.gitconfig" "$HOME"
ln -sv "$PWD/.gitmessage" "$HOME"
