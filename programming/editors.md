# Editors

- [Editors](#editors)
  - [Vim](#vim)

## Vim

Uses [.vimrc](assets/.vimrc).

```sh
mkdir -p ~/.vim/swap ~/.vim/undo
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp <assets/.vimrc> ~
dos2unix ~/.vimrc # ensure line endings are correct
vim +PlugInstall +qall
```
