# Linux

- [Linux](#linux)
  - [ViM](#vim)

## ViM

Uses [.vimrc](/assets/.vimrc).

```sh
mkdir -p ~/.vim/swap ~/.vim/undo
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp <assets/.vimrc> ~
vim +PlugInstall +qall
```
