brew bundle

# Symlink dotfiles
ln -sv "$PWD/.zshrc" "$HOME"

ln -sv "$PWD/.gitconfig" "$HOME"
ln -sv "$PWD/.gitmessage" "$HOME"